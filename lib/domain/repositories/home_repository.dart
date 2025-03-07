import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';

/// Repository interface for managing home data.
///
/// This interface defines the data operations related to homes and their
/// associated assets.
abstract class HomeRepository {
  /// Retrieves all homes from the data source.
  Future<List<Home>> getHomes();

  /// Retrieves a specific home by its ID.
  ///
  /// Returns the home if found, otherwise throws an exception.
  Future<Home> getHomeById(int id);

  /// Adds a new home to the data source.
  ///
  /// Returns the saved home with any server-generated fields.
  Future<Home> addHome(Home home);

  /// Updates an existing home in the data source.
  ///
  /// Returns the updated home after the changes are saved.
  Future<Home> updateHome(Home home);

  /// Deletes a home from the data source.
  Future<void> deleteHome(int id);

  /// Adds an asset to a specific home.
  Future<void> addAssetToHome(int homeId, Asset asset);

  /// Removes an asset from a specific home.
  Future<void> removeAssetFromHome(int homeId, int assetId);

  /// Returns a list of predefined assets that can be added to homes.
  List<Asset> getPredefinedAssets();
}
