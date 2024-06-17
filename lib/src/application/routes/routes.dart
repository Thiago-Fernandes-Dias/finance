import 'package:finance/src/application/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'builders.dart';
part 'paths.dart';

final goRouter = GoRouter(
  initialLocation: Paths.register,
  // initialLocation: Paths.root,
  routes: [
    GoRoute(path: Paths.register, builder: _registerScreenBuilder),
  ],
);
