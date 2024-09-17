part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState extends Equatable {
  final UserModel user;
  final AuthStatus status;
  const AuthState({
    this.user = const UserModel(pk: 0, email: '', firstName: '', lastName: ''),
    this.status = AuthStatus.initial,
  });

  AuthState copyWith({
    UserModel? user,
    AuthStatus? status,
  }) {
    return AuthState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
