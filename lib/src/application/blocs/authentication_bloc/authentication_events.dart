part of 'authentication_bloc.dart';

abstract class AuthenticationEvents implements Equatable {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

final class RegisterEvent extends AuthenticationEvents {
  RegisterEvent({
    required this.email,
    required this.password,
    required this.confirmation,
  });

  final String email;
  final String password;
  final String confirmation;

  @override
  List<Object?> get props => [email, password, confirmation];
}

final class LoginEvent extends AuthenticationEvents {
  LoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
