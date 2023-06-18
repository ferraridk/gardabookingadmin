import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:gardabookingadmin/repositories/base_auth_repository.dart';
import 'package:gardabookingadmin/repositories/user_repository.dart';

import '../models/user_model.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final UserRepository _userRepository;

  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    required UserRepository userRepository,
  })  : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _userRepository = userRepository;

  @override
  Future<auth.User?> signUp({
    required User user,
    required String password,
  }) async {
    try {
      final auth.UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      if (userCredential.user != null) {
        await _userRepository.createUser(
          user.copyWith(id: userCredential.user!.uid),
        );
      }

      return userCredential.user;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {}
  }

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> validateCredentials({
    required String email,
    required String password,
  }) async {
    try {
      final auth.UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user != null;
    } catch (_) {
      return false;
    }
  }
}
