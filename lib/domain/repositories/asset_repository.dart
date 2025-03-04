import '../models/asset/asset.dart';

abstract class AssetRepository {
  Future<List<Asset>> getAssets();
  Future<Asset> getAssetById(int id);
  Future<List<Asset>> getAssetsByCategory(String category);
  Future<Asset> addAsset(Asset asset);
  Future<Asset> updateAsset(Asset asset);
  Future<void> deleteAsset(int id);
}
