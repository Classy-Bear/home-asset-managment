import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/modules/widgets/confirm_delete.dart';

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

class HomesList extends StatelessWidget {
  final List<Home> homes;

  const HomesList({super.key, required this.homes});

  @override
  Widget build(BuildContext context) {
    if (homes.isEmpty) {
      return Center(
        child: Text(
          'No homes yet. Add your first home!',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }
    return ListView.builder(
      itemCount: homes.length,
      itemBuilder: (context, index) {
        final home = homes[index];
        return HomeListItem(
          home: home,
          onTap: () => context.pushNamed('home-detail',
              pathParameters: {'homeId': home.id.toString()}),
          onDelete: () => _deleteHome(context, home.id),
          onEdit: () => context.pushNamed('edit-home',
              pathParameters: {'homeId': home.id.toString()}),
        );
      },
    );
  }

  void _deleteHome(BuildContext context, int homeId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ConfirmDelete(
          context: dialogContext,
          onPressed: () => context.read<HomeCubit>().deleteHome(homeId),
        );
      },
    );
  }
}

class HomeListItem extends StatelessWidget {
  final Home home;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const HomeListItem({
    super.key,
    required this.home,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          home.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(home.address.formattedAddress),
        trailing: Text(
          '${home.assets.length} assets',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        onTap: onTap,
      ),
    );
  }
}
