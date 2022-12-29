import 'package:finance/src/application/screens/home_screen/home_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'builders.dart';

final goRouter = GoRouter(
  initialLocation: '/sign-in',
  routes: [
    GoRoute(path: '/sign-in', builder: _signInScreenBuilder),
    GoRoute(path: '/register', builder: _registerScreenBuilder),
    GoRoute(path: '/forgot-password', builder: _forgotPasswordScreenBuilder),
    GoRoute(path: '/', builder: _homeScreenBuilder),
  ],
);
