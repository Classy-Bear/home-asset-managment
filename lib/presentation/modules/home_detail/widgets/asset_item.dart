part of 'widgets.dart';

/// A widget that displays an asset of a home.
///
/// This widget shows an asset of a home, including its name, description, and category.
/// The user can also remove the asset from the home.
class AssetItem extends StatelessWidget {
  /// The asset to display.
  final Asset asset;

  /// The ID of the home to display.
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
