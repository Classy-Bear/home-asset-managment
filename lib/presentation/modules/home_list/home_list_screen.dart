import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';
import 'widgets/widgets.dart';

/// A screen that displays a list of homes.
///
/// This screen shows a list of homes and allows the user to add a new home.
/// The homes are fetched from the [HomeCubit] and displayed in a list.
/// The user can also edit or delete a home.
class HomeListScreen extends StatelessWidget {
  const HomeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Homes'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.fetchStatus.isInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Initial state'),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadHomes(),
                    child: const Text('Load Homes'),
                  ),
                ],
              ),
            );
          } else if (state.fetchStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.fetchStatus.isLoaded) {
            return HomesList(homes: state.homes);
          } else if (state.fetchStatus.isError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('new-home'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
