import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'constants.dart';

/// Wraps the firebase auth functionality into a service
class FirebaseAuthenticationService {
  /// An Instance of Logger that can be used to log out what's happening in the service
  final Logger log;

  /// The URI to which the authorization redirects. It must include a domain name, and can’t be an IP address or localhost.
  ///
  /// Must be configured at https://developer.apple.com/account/resources/identifiers/list/serviceId
  final appleRedirectUri;

  /// The developer’s client identifier, as provided by WWDR.
  ///
  /// This is the Identifier value shown on the detail view of the service after opening it from https://developer.apple.com/account/resources/identifiers/list/serviceId
  /// Usually a reverse domain notation like com.example.app.service
  final appleClientId;

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _facebookLogin = FacebookLogin();

  FirebaseAuthenticationService({
    this.appleRedirectUri,
    this.appleClientId,
    this.log,
  });

  String _pendingEmail;
  AuthCredential _pendingCredential;

  Future<UserCredential> _signInWithCredential(
    AuthCredential credential,
  ) async {
    return _firebaseAuth.signInWithCredential(credential);
  }

  /// Returns the latest userToken stored in the Firebase Auth lib
  Future<String> get userToken {
    return _firebaseAuth.currentUser?.getIdToken();
  }

  /// Returns true when a user has logged in or signed on this device
  bool get hasUser {
    return _firebaseAuth?.currentUser != null;
  }

  Future<FirebaseAuthenticationResult> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        log?.i('Process is canceled by the user');
        return null;
      }
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      var result = await _signInWithCredential(credential);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user.linkWithCredential(_pendingCredential);
        _clearPendingData();
      }

      return FirebaseAuthenticationResult(
        uid: result.user.uid,
        userToken: result.user.refreshToken,
      );
    } on FirebaseAuthException catch (e) {
      log?.e(e);
      return await _handleAccountExists(e);
    } catch (e) {
      log?.e(e);
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }
  }

  Future<bool> isAppleSignInAvailable() async {
    return await SignInWithApple.isAvailable();
  }

  Future<FirebaseAuthenticationResult> signInWithApple() async {
    try {
      if (appleClientId == null) {
        throw FirebaseAuthException(
          message:
              'If you want to use Apple Sign In you have to provide a appleClientId to the FirebaseAuthenticationService',
          code: StackedFirebaseAuthAppleClientIdMissing,
        );
      }

      if (appleRedirectUri == null) {
        throw FirebaseAuthException(
          message:
              'If you want to use Apple Sign In you have to provide a appleRedirectUri to the FirebaseAuthenticationService',
          code: StackedFirebaseAuthAppleClientIdMissing,
        );
      }

      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: appleClientId,
          redirectUri: Uri.parse(appleRedirectUri),
        ),
        nonce: nonce,
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleIdCredential.identityToken,
        accessToken: appleIdCredential.authorizationCode,
        rawNonce: rawNonce,
      );

      var result = await _signInWithCredential(credential);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user.linkWithCredential(_pendingCredential);
        _clearPendingData();
      }

      return FirebaseAuthenticationResult(
        uid: result.user.uid,
        userToken: result.user.refreshToken,
      );
    } on FirebaseAuthException catch (e) {
      log?.e(e);
      return await _handleAccountExists(e);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) return null;

      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    } catch (e) {
      log?.e(e);
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseAuthenticationResult> signInWithFacebook() async {
    log?.i('');

    try {
      FacebookLoginResult loginResult = await _facebookLogin.logIn(['email']);
      log?.v(
          'Facebook Sign In complete. \nstatus:${loginResult.status} \naccessToken:${loginResult.accessToken} \nerrorMessage:${loginResult.errorMessage}');

      if (loginResult.status == FacebookLoginStatus.cancelledByUser) {
        log?.i('Process is canceled by the user');
        return null;
      }

      if (loginResult.status == FacebookLoginStatus.error) {
        return FirebaseAuthenticationResult.error(
          errorMessage: loginResult.errorMessage,
        );
      }

      var facebookCredentials =
          FacebookAuthProvider.credential(loginResult.accessToken.token);

      var result = await _signInWithCredential(facebookCredentials);

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user.linkWithCredential(_pendingCredential);
        _clearPendingData();
      }

      return FirebaseAuthenticationResult(
        uid: result.user.uid,
        userToken: result.user.refreshToken,
      );
    } on FirebaseAuthException catch (e) {
      log?.e(e);
      return await _handleAccountExists(e);
    } catch (e) {
      log?.e(e);
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }
  }

  Future<FirebaseAuthenticationResult> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      log?.d('email:$email');
      var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log?.d('Sign in with email result: ${result.credential} ${result.user}');

      // Link the pending credential with the existing account
      if (_pendingCredential != null) {
        await result.user.linkWithCredential(_pendingCredential);
        _clearPendingData();
      }

      return FirebaseAuthenticationResult(
        uid: result.user.uid,
        userToken: result.user.refreshToken,
      );
    } on FirebaseAuthException catch (e) {
      log?.e('A firebase exception has occured. $e');
      return FirebaseAuthenticationResult.error(
          errorMessage: getErrorMessageFromFirebaseException(e));
    } on Exception catch (e) {
      log?.e('A general exception has occured. $e');
      return FirebaseAuthenticationResult.error(
          errorMessage:
              'We could not log into your account at this time. Please try again.');
    }
  }

  /// Uses `createUserWithEmailAndPassword` to sign up to the Firebase application
  Future<FirebaseAuthenticationResult> createAccountWithEmail(
      {String email, String password}) async {
    try {
      log?.d('email:$email');
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      log?.d(
          'Create user with email result: ${result.credential} ${result.user}');

      return FirebaseAuthenticationResult(
        uid: result.user.uid,
        userToken: result.user.refreshToken,
      );
    } on FirebaseAuthException catch (e) {
      log?.e('A firebase exception has occured. $e');
      return FirebaseAuthenticationResult.error(
          errorMessage: getErrorMessageFromFirebaseException(e));
    } on Exception catch (e) {
      log?.e('A general exception has occured. $e');
      return FirebaseAuthenticationResult.error(
          errorMessage:
              'We could not create your account at this time. Please try again.');
    }
  }

  Future<FirebaseAuthenticationResult> _handleAccountExists(
      FirebaseAuthException e) async {
    if (e.code != 'account-exists-with-different-credential') {
      return FirebaseAuthenticationResult.error(errorMessage: e.toString());
    }

    // The account already exists with a different credential
    _pendingEmail = e.email;
    _pendingCredential = e.credential;

    // Fetch a list of what sign-in methods exist for the conflicting user
    List<String> userSignInMethods =
        await _firebaseAuth.fetchSignInMethodsForEmail(_pendingEmail);

    // If the user has several sign-in methods,
    // the first method in the list will be the "recommended" method to use.

    // Check if the recommended account is email then tell them to sign up with email
    if (userSignInMethods.first == 'password') {
      return FirebaseAuthenticationResult.error(
        errorMessage:
            // 'We don’t have the ability to merge social accounts with existing Delivery Dudes accounts. Log in using the same email as this social platform.',
            'To link your Facebook account with your existing account, please sign in with your email address and password.',
      );
    }

    // Since other providers are now external, you must now sign the user in
    // with another auth provider, such as Facebook.
    if (userSignInMethods.first == 'facebook.com') {
      return FirebaseAuthenticationResult.error(
        errorMessage:
            'We could not log into your account but we noticed you have a Facebook account with the same details. Please try to login with Facebook.',
      );
    }

    if (userSignInMethods.first == 'google.com') {
      return FirebaseAuthenticationResult.error(
        errorMessage:
            'We could not log into your account but we noticed you have a Google account with the same details. Please try to login with Google.',
      );
    }

    if (userSignInMethods.first == 'apple') {
      return FirebaseAuthenticationResult.error(
        errorMessage:
            'We could not log into your account but we noticed you have a Apple account with the same details. Please try to login with your Apple account instead.',
      );
    }

    // This is here to ensure if we ever get into this function we HAVE to give the user feedback on this error. So we use the sign In methods recommended account
    // and the throw the user an exception.
    return FirebaseAuthenticationResult.error(
      errorMessage:
          'We could not log into your account but we noticed you have a ${userSignInMethods.first} account with the same details. Please try to login with that instead.',
    );
  }

  /// Sign out of the social accounts that have been used
  Future logout() async {
    log?.i('');

    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      await _facebookLogin.logOut();
      _clearPendingData();
    } catch (e) {
      log?.e('Could not sign out of social account. $e');
    }
  }

  void _clearPendingData() {
    _pendingEmail = null;
    _pendingCredential = null;
  }

  /// Send reset password link to email
  Future sendResetPasswordLink(String email) async {
    log?.i('email:$email');

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      log?.e('Could not send email with reset password link. $e');
      return false;
    }
  }

  /// Validate the current [password] of the Firebase User
  Future validatePassword(String password) async {
    try {
      var authCredentials = EmailAuthProvider.credential(
        email: _firebaseAuth.currentUser.email,
        password: password,
      );

      var authResult = await _firebaseAuth.currentUser
          .reauthenticateWithCredential(authCredentials);

      return authResult.user != null;
    } catch (e) {
      log?.e('Could not validate the user password. $e');
      return FirebaseAuthenticationResult.error(
          errorMessage: 'The current password is not valid.');
    }
  }

  /// Update the [password] of the Firebase User
  Future updatePassword(String password) async {
    await _firebaseAuth.currentUser.updatePassword(password);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}

class FirebaseAuthenticationResult {
  /// The users unique id
  final String uid;

  /// The authentication token associated with the user
  final String userToken;

  /// Contains the error message for the request
  final String errorMessage;

  FirebaseAuthenticationResult({this.uid, this.userToken})
      : errorMessage = null;

  FirebaseAuthenticationResult.error({this.errorMessage})
      : uid = null,
        userToken = null;

  /// Returns true if the response has an error associated with it
  bool get hasError => errorMessage != null && errorMessage.isNotEmpty;
}

String getErrorMessageFromFirebaseException(FirebaseAuthException exception) {
  switch (exception.code.toLowerCase()) {
    case 'email-already-in-use':
      return 'An account already exists for the email you\'re trying to use. Login instead.';
    case 'invalid-email':
      return 'The email you\'re using is invalid. Please use a valid email.';
    case 'operation-not-allowed':
      return 'The authentication is not enabled on Firebase. Please enable the Authentitcation type on Firebase';
    case 'weak-password':
      return 'Your password is too weak. Please use a stronger password.';
    case 'wrong-password':
      return 'You seemed to have entered the wrong password. Double check it and try again.';
    default:
      return exception.message ??
          'Something went wrong on our side. Please try again';
  }
}
