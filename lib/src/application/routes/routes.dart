import 'package:finance/src/application/screens/home_screen/home_screen.dart';
import 'package:finance/src/application/screens/login_screen/login_screen.dart';
import 'package:finance/src/application/screens/registration_screen/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'builders.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/sign-in', builder: _signInScreenBuilder),
    GoRoute(path: '/register', builder: _registerScreenBuilder),
    GoRoute(path: '/', builder: _homeScreenBuilder),
  ],
);
