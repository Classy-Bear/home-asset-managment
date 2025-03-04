import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/modules/screens/asset_selector_screen.dart';
import 'package:home_asset_managment/modules/screens/home_detail_screen.dart';
import 'package:home_asset_managment/modules/screens/home_form_screen.dart';
import 'package:home_asset_managment/modules/screens/home_list_screen.dart';

/// The router configuration for the app.
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
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(
      title: const Text('Not Found'),
    ),
    body: Center(
      child: Text('No route defined for ${state.uri.path}'),
    ),
  ),
);
