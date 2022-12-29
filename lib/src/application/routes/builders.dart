part of 'routes.dart';

Widget _homeScreenBuilder(BuildContext context, GoRouterState state) {
  return const HomeScreen();
}

Widget _signInScreenBuilder(BuildContext context, GoRouterState state) {
  return SignInScreen(
    resizeToAvoidBottomInset: true,
    providers: [EmailAuthProvider()],
    actions: [
      ForgotPasswordAction((context, email) {
        context.push(
          '/forgot-password',
          extra: email,
        );
      }),
      AuthStateChangeAction<SignedIn>((context, state) => context.go('/')),
    ],
  );
}

Widget _registerScreenBuilder(BuildContext context, GoRouterState state) {
  return RegisterScreen(
    resizeToAvoidBottomInset: true,
    providers: [EmailAuthProvider()],
    actions: [
      AuthStateChangeAction<SignedIn>((context, state) => context.go('/sign-in')),
    ],
  );
}

Widget _forgotPasswordScreenBuilder(BuildContext context, GoRouterState state) {
  return ForgotPasswordScreen(
    resizeToAvoidBottomInset: true,
    email: state.extra as String,
  );
}
