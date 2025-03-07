import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'widgets/widgets.dart';

/// A screen that displays the details of a home.
///
/// This screen shows the details of a home, including its name, address, and assets.
/// The user can also add a new asset to the home.
class HomeDetailScreen extends StatelessWidget {
  /// The ID of the home to display.
  final int homeId;

  const HomeDetailScreen({super.key, required this.homeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.fetchStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.fetchStatus.isLoaded) {
            return HomeDetailView(
              home: state.homes.firstWhere((home) => home.id == homeId),
            );
          } else if (state.fetchStatus.isError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(
          'asset-selector',
          pathParameters: {
            'homeId': homeId.toString(),
          },
        ),
        tooltip: 'Add Asset',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// A widget that displays the details of a home.
///
/// This widget shows the details of a home, including its name, address, and assets.
/// The user can also add a new asset to the home.
class HomeDetailView extends StatelessWidget {
  /// The home to display.
  final Home home;

  const HomeDetailView({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeInfoCard(home: home),
          const SizedBox(height: 24),
          AssetsSection(home: home),
        ],
      ),
    );
  }
}
