import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'widgets/widgets.dart';

/// A screen that displays a list of assets for a home.
///
/// This screen shows a list of assets that can be added to a home.
/// The user can search for an asset by name, category, description, or manufacturer.
/// The user can also add an asset to the home.
class AssetSelectorScreen extends StatefulWidget {
  /// The ID of the home to display.
  final int homeId;

  const AssetSelectorScreen({super.key, required this.homeId});

  @override
  State<AssetSelectorScreen> createState() => _AssetSelectorScreenState();
}

/// The state of the asset selector screen.
///
/// This class manages the state of the asset selector screen.
/// It contains the list of available assets, the search query, and the search controller.
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
          AssetSearchBar(
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
