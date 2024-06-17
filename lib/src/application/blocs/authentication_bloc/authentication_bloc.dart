import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:finance/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_events.dart';
part 'authentication_state.dart';

abstract class AuthenticationBloc extends Bloc<AuthenticationEvents, AuthenticationState> {
  AuthenticationBloc(super.initialState) {
    on<RegisterEvent>(registerHandler);
    on<LoginEvent>(loginHandler);
  }

  @protected
  FutureOr<void> registerHandler(RegisterEvent event, Emitter<AuthenticationState> emit);

  @protected
  FutureOr<void> loginHandler(LoginEvent event, Emitter<AuthenticationState> emit);
}

final class FirebaseAuthenticationBloc extends AuthenticationBloc {
  FirebaseAuthenticationBloc(this._firebaseAuth) : super(AuthenticationIdleState());

  final FirebaseAuth _firebaseAuth; 
  
  @override
  FutureOr<void> loginHandler(LoginEvent event, Emitter<AuthenticationState> emit) {
    throw UnimplementedError();
  }
  
  @override
  Future<void> registerHandler(RegisterEvent event, Emitter<AuthenticationState> emit) async {
    if (event.password != event.confirmation) {
      emit(AuthenticationErrorState(Exception())); // TODO: exception mais específica
    }
    try {
      final RegisterEvent(:email, :password) = event;
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user!;
      final userInfo = CurrentUserInfo(email: user.email!, userId: user.uid);
      emit(AuthenticationSuccessfulState(userInfo: userInfo));
    } on Exception catch (e) {
      emit(AuthenticationErrorState(e)); // TODO: exception mais específica
    }
  }
}