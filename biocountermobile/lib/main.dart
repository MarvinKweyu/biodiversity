import 'package:biocountermobile/core/routes.dart';
import 'package:biocountermobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:biocountermobile/features/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc())
        ],
        child: MaterialApp.router(
          title: 'Bio-diversity ',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.soraTextTheme(),
            useMaterial3: true,
          ),
          // routerDelegate: _routerDelegate,
          // routeInformationParser: _routeInformationParser,
          routerConfig: routes,
        ));
  }
}
