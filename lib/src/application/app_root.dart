import 'package:finance/src/application/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:finance/src/application/routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        Provider<AuthenticationBloc>.value(
          value: FirebaseAuthenticationBloc(FirebaseAuth.instance),
        )
      ],
      child: MaterialApp.router(
        routeInformationParser: goRouter.routeInformationParser,
        routeInformationProvider: goRouter.routeInformationProvider,
        routerDelegate: goRouter.routerDelegate,
      ),
    );
  }
}
