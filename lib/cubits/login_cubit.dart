import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../repositories/auth_repository.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({
    required AuthRepository authRepository
}) : _authRepository = authRepository,
  super(LoginState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        status: LoginStatus.initial,
      ),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(
        password: value,
        status: LoginStatus.initial,
      ),
    );
  }

  Future<bool> logInWithCredentials() async {
    if (state.status == LoginStatus.submitting) return false;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      // Perform the validation logic here
      bool isValidCredentials = await _authRepository.validateCredentials(
        email: state.email,
        password: state.password,
      );
      if (isValidCredentials) {
        // If the credentials are valid, log in
        await _authRepository.logInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(status: LoginStatus.success));
        return true; // Return true for successful login
      } else {
        // If the credentials are invalid, return false
        emit(state.copyWith(status: LoginStatus.error));
        return false; // Return false for failed login
      }
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.error));
      return false; // Return false for failed login
    }
  }

}