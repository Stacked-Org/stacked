import 'package:injectable/injectable.dart';
import 'package:new_architecture/services/cloud_storage_service.dart';
import 'package:new_architecture/services/firebase_authentication.dart';

@lazySingleton
class AuthenticationManager {
  final FirebaseAuthentication firebaseAuthentication;
  final CloudStorageService cloudStorageService;
  AuthenticationManager(
    this.firebaseAuthentication,
    this.cloudStorageService,
  );
}
