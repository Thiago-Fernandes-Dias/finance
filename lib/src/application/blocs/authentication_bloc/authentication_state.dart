part of 'authentication_bloc.dart';

abstract class AuthenticationState implements Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

final class AuthenticationSuccessfulState extends AuthenticationState {
  AuthenticationSuccessfulState({required this.userInfo});

  final CurrentUserInfo userInfo;
}

final class AuthenticationIdleState extends AuthenticationState {}

final class AuthenticationErrorState extends AuthenticationState {
  AuthenticationErrorState(this.exception);

  final Exception exception;
}