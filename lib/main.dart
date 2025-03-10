import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/data/repositories/in_memory_home_repository.dart';
import 'package:home_asset_managment/router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

/// Entry point for the Home Asset Management application.
///
/// Initializes Firebase, sets up HydratedBloc for state persistence,
/// and starts the Flutter application.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HydratedBloc.storage = await initializeStorage();
  usePathUrlStrategy();
  runApp(const MyApp());
}

/// Initializes storage for HydratedBloc based on platform.
///
/// On web platforms, uses web storage directory. On other platforms,
/// uses the application documents directory.
///
/// Returns a [Storage] instance for HydratedBloc.
Future<Storage> initializeStorage() async {
  return HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}

/// Root widget of the Home Asset Management application.
///
/// Sets up the application theme, dependency injection for state management,
/// and configures the router for navigation.
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
