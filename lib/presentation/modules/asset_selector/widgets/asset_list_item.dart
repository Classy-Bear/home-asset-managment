part of 'widgets.dart';

/// A widget that displays an asset of a home.
///
/// This widget shows an asset of a home, including its name, description, and category.
/// The user can also add the asset to the home.
class AssetListItem extends StatelessWidget {
  /// The asset to display.
  final Asset asset;
  /// The ID of the home to display.
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
