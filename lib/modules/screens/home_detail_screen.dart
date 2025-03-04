import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'package:home_asset_managment/modules/widgets/confirm_delete.dart';

class HomeDetailScreen extends StatelessWidget {
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
          print('state.fetchStatus home_detail_screen: ${state.fetchStatus} ${state.homes.firstWhere((home) => home.id == homeId).assets.length}');
          if (state.fetchStatus.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.fetchStatus.isLoaded) {
            return HomeDetailView(
                home: state.homes.firstWhere((home) => home.id == homeId));
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

class HomeDetailView extends StatelessWidget {
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

class HomeInfoCard extends StatelessWidget {
  final Home home;

  const HomeInfoCard({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              home.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    home.address.formattedAddress,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.build, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Assets: ${home.assets.length}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AssetsSection extends StatelessWidget {
  final Home home;

  const AssetsSection({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Assets',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        home.assets.isEmpty
            ? const Center(
                child: Text(
                  'No assets yet. Add your first asset!',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: home.assets.length,
                itemBuilder: (context, index) {
                  return AssetItem(
                    asset: home.assets[index],
                    homeId: home.id,
                  );
                },
              ),
      ],
    );
  }
}

class AssetItem extends StatelessWidget {
  final Asset asset;
  final int homeId;

  const AssetItem({super.key, required this.asset, required this.homeId});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _removeAsset(context),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Remove',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getCategoryColor(),
            child: Icon(
              _getCategoryIcon(),
              color: Colors.white,
            ),
          ),
          title: Text(
            asset.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(asset.description),
              if (asset.manufacturer != null)
                Text('Manufacturer: ${asset.manufacturer}'),
              if (asset.modelNumber != null)
                Text('Model: ${asset.modelNumber}'),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    switch (asset.category.toLowerCase()) {
      case 'hvac':
        return Colors.orange;
      case 'appliance':
        return Colors.blue;
      case 'energy':
        return Colors.green;
      case 'plumbing':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon() {
    switch (asset.category.toLowerCase()) {
      case 'hvac':
        return Icons.air;
      case 'appliance':
        return Icons.kitchen;
      case 'energy':
        return Icons.bolt;
      case 'plumbing':
        return Icons.water_drop;
      default:
        return Icons.build;
    }
  }

  void _removeAsset(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return ConfirmDelete(
          context: dialogContext,
          onPressed: () =>
              context.read<HomeCubit>().removeAssetFromHome(homeId, asset.id),
        );
      },
    );
  }
}
