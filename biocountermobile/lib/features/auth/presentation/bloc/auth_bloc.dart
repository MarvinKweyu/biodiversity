import 'package:biocountermobile/features/auth/data/datasources/auth.dart';
import 'package:biocountermobile/features/auth/data/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:developer' as devtools show log;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthService authService = AuthService();
  AuthBloc() : super(AuthInitial()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));
    authService.signUp(event.name, event.email, event.password).then((value) {
      emit(state.copyWith(status: AuthStatus.success, user: value.user));
    }).catchError((error) {
      emit(state.copyWith(status: AuthStatus.error));
    });
  }

  void _onSignIn(SignInEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));
    authService.signIn(event.email, event.password).then((value) {
      devtools.log(value.toString());
      emit(state.copyWith(status: AuthStatus.success, user: value.user));
    }).catchError((error) {
      emit(state.copyWith(status: AuthStatus.error));
    });
  }

  void _onSignOut(SignOutEvent event, Emitter<AuthState> emit) {
    // implement signout logic
  }
}
