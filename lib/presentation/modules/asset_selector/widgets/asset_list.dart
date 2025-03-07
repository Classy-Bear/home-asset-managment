part of 'widgets.dart';

/// A widget that displays a list of assets for a home.
///
/// This widget shows a list of assets that can be added to a home.
/// The user can search for an asset by name, category, description, or manufacturer.
/// The user can also add an asset to the home.
class AssetList extends StatelessWidget {
  /// The list of assets to display.
  final List<Asset> assets;
  /// The ID of the home to display.
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

