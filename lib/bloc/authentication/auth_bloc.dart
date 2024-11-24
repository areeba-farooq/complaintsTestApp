import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/authentication/auth_event.dart';
import 'package:test_app/bloc/authentication/auth_state.dart';
import 'package:test_app/services/auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<FingerprintAuthEvent>(_handleFingerprintAuth);
    on<PasswordAuthEvent>(_handlePasswordAuth);
  }

  // Handle Fingerprint Authentication
  Future<void> _handleFingerprintAuth(
      FingerprintAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool isAuthenticated = await authService.authenticate();
      if (isAuthenticated) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Fingerprint authentication failed.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Handle Password Authentication
  Future<void> _handlePasswordAuth(
      PasswordAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool isAuthenticated =
          await authService.authenticateWithPassword(event.password);
      if (isAuthenticated) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Password authentication failed.'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
