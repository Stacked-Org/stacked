## 0.2.16

- Improves google sign in error handling

## 0.2.15

- Improves error responses from auth failures

## 0.2.14

- Extracts first and last name from apple credential to create displayName on FirebaseAuth user

## 0.2.13
- Add requestVerificationCode (Implements Native Platform)
- Add authenticateWithOtp (Implements Native Platform)

## 0.2.12
- Adds sign in with phone number
- Adds verify otp 

## 0.2.11

- Updates firebase_core to ^1.17.0
- Updates firebase_auth to ^3.3.18
- Updates google_sign_in to ^5.3.1
- Updates sign_in_with_apple to ^4.0.0


## 0.2.10+2

- Updates 'google_sign_in' to 5.2.1

## 0.2.10+1

- Updates firebase core to 1.10.0
- Updates fireabse_auth to 3.2.0

## 0.2.10

- Initailized Firebase Auth Exceptions error code.

## 0.2.9

- Added Firebase Auth Exceptions error code to FirebaseAuthenticationResult

## 0.2.8

- Bump dependencies to latest

## 0.2.7

- Added a method `updateEmail` to update firebase user email address.

## 0.2.6

- Expose authStateChanges from FirebaseAuth

## 0.2.5

- Anonymous Login Added

## 0.2.4

- Added a method `emailExists` to check if email is registered in Firebase Auth

## 0.2.3

- Added a getter for the current logged in Firebase User

## 0.2.2+1

- Deprecates constructor values for `FirebaseAuthenticationService` and prefers parameters through sign in method

## 0.2.2

- Adds the required apple parameters to `signInWithApple` function

## 0.2.1

- Removed `flutter_facebook_auth` dependency
- Removed implementation for Facebook Authentication

## 0.1.3

- Replaced `flutter_facebook_login` with `flutter_facebook_auth`

## 0.1.2

Updates dependencies

- `firebase_core`: ^1.0.1
- `firebase_auth`: ^1.0.1

## 0.1.1

- Adds `nonce` to remove the probability of a replay attack when using `AppleSignIn`

## 0.1.0+1

- Readme formatting update

## 0.1.0

- Adds the implementations for Email, Google, Facebook and Apple
