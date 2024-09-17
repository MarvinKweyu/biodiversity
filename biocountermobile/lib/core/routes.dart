import 'package:biocountermobile/features/auth/presentation/pages/signin_page.dart';
import 'package:biocountermobile/features/home/presentation/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: 'signin',
        builder: (context, state) => const Home(),
        routes: [
          GoRoute(
              path: 'home',
              name: 'home',
              builder: (context, state) => const Home()),
        ]),
  ],
);

    // TodoInfo(id: state.pathParameters['id']!),
