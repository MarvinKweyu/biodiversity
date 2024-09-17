import 'package:biocountermobile/core/utils/constants.dart';
import 'package:biocountermobile/features/auth/presentation/pages/signin_page.dart';
import 'package:biocountermobile/features/auth/presentation/pages/signup_screen.dart';
import 'package:biocountermobile/features/home/presentation/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: loginScreen,
      // builder: (context, state) => const SignInPage(),
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/$signUpScreen',
      name: signUpScreen,
      // builder: (context, state) => const SignupPage(),
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/$homeScreen',
      name: homeScreen,
      builder: (context, state) => const Home(),
    ),
  ],
);

// TodoInfo(id: state.pathParameters['id']!),
