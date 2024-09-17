import 'package:biocountermobile/core/utils/constants.dart';
import 'package:biocountermobile/features/home/presentation/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: homeScreen,
      builder: (context, state) => const Home(),
    )
  ],
);

// TodoInfo(id: state.pathParameters['id']!),
