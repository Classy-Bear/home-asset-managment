import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';

class AssetSelectorScreen extends StatefulWidget {
  final int homeId;

  const AssetSelectorScreen({super.key, required this.homeId});

  @override
  State<AssetSelectorScreen> createState() => _AssetSelectorScreenState();
}

class _AssetSelectorScreenState extends State<AssetSelectorScreen> {
  late List<Asset> _availableAssets;
  String? _searchQuery;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAssets();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadAssets() {
    // Get predefined assets from repository
    final repository = context.read<HomeCubit>().homeRepository;
    _availableAssets = repository.getPredefinedAssets();
  }

  List<Asset> get _filteredAssets {
    if (_searchQuery == null || _searchQuery!.isEmpty) {
      return _availableAssets;
    }
    final query = _searchQuery!.toLowerCase();
    return _availableAssets.where((asset) {
      return asset.name.toLowerCase().contains(query) ||
          asset.category.toLowerCase().contains(query) ||
          asset.description.toLowerCase().contains(query) ||
          (asset.manufacturer != null &&
              asset.manufacturer!.toLowerCase().contains(query));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Asset'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          SearchBar(
            searchController: _searchController,
            searchQuery: _searchQuery,
            onSearchChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          Expanded(
            child: AssetList(
              assets: _filteredAssets,
              homeId: widget.homeId,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String? searchQuery;
  final ValueChanged<String?> onSearchChanged;

  const SearchBar({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Search assets...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: searchQuery != null && searchQuery!.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    onSearchChanged(null);
                  },
                )
              : null,
        ),
        onChanged: onSearchChanged,
      ),
    );
  }
}

class AssetList extends StatelessWidget {
  final List<Asset> assets;
  final int homeId;

  const AssetList({
    super.key,
    required this.assets,
    required this.homeId,
  });

  @override
  Widget build(BuildContext context) {
    if (assets.isEmpty) {
      return const Center(
        child: Text(
          'No assets found',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: assets.length,
      itemBuilder: (context, index) {
        final asset = assets[index];
        return AssetListItem(
          asset: asset,
          homeId: homeId,
        );
      },
    );
  }
}

class AssetListItem extends StatelessWidget {
  final Asset asset;
  final int homeId;

  const AssetListItem({
    super.key,
    required this.asset,
    required this.homeId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            Text(asset.category),
            Text(
              asset.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.add_circle),
          color: Theme.of(context).colorScheme.primary,
          onPressed: () => _addAssetToHome(context),
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

  void _addAssetToHome(BuildContext context) {
    context.read<HomeCubit>().addAssetToHome(homeId, asset);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${asset.name} added to your home'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}
