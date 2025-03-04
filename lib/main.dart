import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/data/repositories/in_memory_home_repository.dart';
import 'package:home_asset_managment/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data repository.
    // TODO: Replace with actual data repository.
    final homeRepository = InMemoryHomeRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(homeRepository: homeRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Home Asset Management App',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xff0C3860),
            secondary: Color(0xff0BA884),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xff0BA884),
            foregroundColor: Colors.white,
          ),
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
