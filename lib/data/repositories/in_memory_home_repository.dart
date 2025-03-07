import '../../domain/models/home/home.dart';
import '../../domain/models/asset/asset.dart';
import '../../domain/repositories/home_repository.dart';

/// In-memory implementation of the [HomeRepository] interface.
///
/// This repository stores all data in memory and is intended for development
/// and testing purposes. Data will be lost when the application restarts.
class InMemoryHomeRepository implements HomeRepository {
  /// In-memory storage for homes.
  final List<Home> _homes = [];

  /// Next available ID for new homes.
  int _nextHomeId = 1;

  /// Predefined list of assets that can be added to homes.
  static const List<Asset> _predefinedAssets = [
    Asset(
      id: 1,
      name: 'Central Air Conditioner',
      category: 'HVAC',
      description: 'Central cooling system for the entire home',
      manufacturer: 'Carrier',
      modelNumber: 'CC-2023-X',
    ),
    Asset(
      id: 2,
      name: 'Gas Furnace',
      category: 'HVAC',
      description: 'Heating system using natural gas',
      manufacturer: 'Trane',
      modelNumber: 'GF-500',
    ),
    Asset(
      id: 3,
      name: 'Refrigerator',
      category: 'Appliance',
      description: 'Kitchen refrigerator/freezer combo',
      manufacturer: 'LG',
      modelNumber: 'LFXS26973',
    ),
    Asset(
      id: 4,
      name: 'Dishwasher',
      category: 'Appliance',
      description: 'Built-in dishwasher',
      manufacturer: 'Bosch',
      modelNumber: 'SHE3AR75UC',
    ),
    Asset(
      id: 5,
      name: 'Solar Panel System',
      category: 'Energy',
      description: '5kW rooftop solar array',
      manufacturer: 'SunPower',
      modelNumber: 'X22-370',
    ),
    Asset(
      id: 6,
      name: 'Water Heater',
      category: 'Plumbing',
      description: '50-gallon tank water heater',
      manufacturer: 'Rheem',
      modelNumber: 'XE50T10HD50U0',
    ),
    Asset(
      id: 7,
      name: 'Washing Machine',
      category: 'Appliance',
      description: 'Front-loading clothes washer',
      manufacturer: 'Samsung',
      modelNumber: 'WF45R6100AP',
    ),
    Asset(
      id: 8,
      name: 'Clothes Dryer',
      category: 'Appliance',
      description: 'Electric clothes dryer',
      manufacturer: 'Samsung',
      modelNumber: 'DVE45R6100C',
    ),
  ];

  InMemoryHomeRepository() {
    // Add some sample homes
    _homes.addAll([
      Home(
        id: 1,
        name: 'Mountain Retreat',
        address: const Address(
          street: '123 Alpine Way',
          city: 'Boulder',
          state: 'CO',
          zipCode: '80304',
        ),
        assets: [_predefinedAssets[0], _predefinedAssets[1]],
      ),
      Home(
        id: 2,
        name: 'Urban Loft',
        address: const Address(
          street: '456 Downtown Ave',
          city: 'Portland',
          state: 'OR',
          zipCode: '97204',
        ),
        assets: [_predefinedAssets[2], _predefinedAssets[3]],
      ),
    ]);
    _nextHomeId = 3; // Set next ID after the initial homes
  }

  @override
  Future<List<Home>> getHomes() async {
    return _homes;
  }

  @override
  Future<Home> getHomeById(int id) async {
    final home = _homes.firstWhere(
      (home) => home.id == id,
      orElse: () => throw Exception('Home not found'),
    );
    return home;
  }

  @override
  Future<Home> addHome(Home home) async {
    final newHome = home.copyWith(id: _nextHomeId++);
    _homes.add(newHome);
    return newHome;
  }

  @override
  Future<Home> updateHome(Home home) async {
    final index = _homes.indexWhere((h) => h.id == home.id);
    if (index == -1) {
      throw Exception('Home not found');
    }
    _homes[index] = home;
    return home;
  }

  @override
  Future<void> deleteHome(int id) async {
    _homes.removeWhere((home) => home.id == id);
  }

  @override
  Future<void> addAssetToHome(int homeId, Asset asset) async {
    final home = await getHomeById(homeId);
    final updatedAssets = [...home.assets, asset];
    final updatedHome = home.copyWith(assets: updatedAssets);
    await updateHome(updatedHome);
  }

  @override
  Future<void> removeAssetFromHome(int homeId, int assetId) async {
    final home = await getHomeById(homeId);
    final updatedAssets =
        home.assets.where((asset) => asset.id != assetId).toList();
    final updatedHome = home.copyWith(assets: updatedAssets);
    await updateHome(updatedHome);
  }

  @override
  List<Asset> getPredefinedAssets() {
    return _predefinedAssets;
  }
}
