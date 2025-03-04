import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';

abstract class HomeRepository {
  Future<List<Home>> getHomes();
  Future<Home> getHomeById(int id);
  Future<Home> addHome(Home home);
  Future<Home> updateHome(Home home);
  Future<void> deleteHome(int id);
  Future<void> addAssetToHome(int homeId, Asset asset);
  Future<void> removeAssetFromHome(int homeId, int assetId);
  List<Asset> getPredefinedAssets();
}
