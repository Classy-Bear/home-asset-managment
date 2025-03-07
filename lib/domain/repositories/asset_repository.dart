import 'package:home_asset_managment/domain/models/asset/asset.dart';

/// Repository interface for managing asset data.
///
/// This interface defines the data operations related to assets.
abstract class AssetRepository {
  /// Retrieves all assets from the data source.
  Future<List<Asset>> getAssets();

  /// Retrieves a specific asset by its ID.
  Future<Asset> getAssetById(int id);

  /// Retrieves assets filtered by category.
  ///
  /// Returns a list of assets that belong to the specified category.
  Future<List<Asset>> getAssetsByCategory(String category);

  /// Adds a new asset to the data source.
  Future<Asset> addAsset(Asset asset);

  /// Updates an existing asset in the data source.
  Future<Asset> updateAsset(Asset asset);

  /// Deletes an asset from the data source.
  Future<void> deleteAsset(int id);
}
