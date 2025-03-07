import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/presentation/modules/asset_selector/asset_selector_screen.dart';
import 'package:home_asset_managment/presentation/modules/home_detail/home_detail_screen.dart';
import 'package:home_asset_managment/presentation/modules/home_form/home_form_screen.dart';
import 'package:home_asset_managment/presentation/modules/home_list/home_list_screen.dart';

/// The application's route configuration.
///
/// Defines all routes for the application using the GoRouter package.
/// The router supports nested routes and parameter-based navigation.
///
/// The routes are defined as follows:
/// - '/': The root route that displays the home list screen.
/// - '/new': The route for creating a new home.
/// - '/:homeId': The route for displaying a specific home's details.
/// - '/:homeId/edit': The route for editing a specific home's details.
/// - '/:homeId/assets': The route for selecting assets for a specific home.
final GoRouter router = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'homes',
      builder: (context, state) => const HomeListScreen(),
      routes: [
        GoRoute(
          path: 'new',
          name: 'new-home',
          builder: (context, state) => const HomeFormScreen(),
        ),
        GoRoute(
          path: ':homeId',
          name: 'home-detail',
          builder: (context, state) {
            final homeId = int.parse(state.pathParameters['homeId']!);
            return HomeDetailScreen(homeId: homeId);
          },
          routes: [
            GoRoute(
              path: 'edit',
              name: 'edit-home',
              builder: (context, state) {
                final homeId = int.parse(state.pathParameters['homeId']!);
                return HomeFormScreen(homeId: homeId);
              },
            ),
            GoRoute(
              path: 'assets',
              name: 'asset-selector',
              builder: (context, state) {
                final homeId = int.parse(state.pathParameters['homeId']!);
                return AssetSelectorScreen(homeId: homeId);
              },
            ),
          ],
        ),
      ],
    ),
  ],
  // Custom error page shown when navigating to an undefined route
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Not Found'),
    ),
    body: Center(
      child: Text('No route defined for ${state.uri.path}'),
    ),
  ),
);
