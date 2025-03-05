import 'package:flutter_test/flutter_test.dart';
import 'package:home_asset_managment/data/repositories/in_memory_home_repository.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';

void main() {
  late InMemoryHomeRepository repository;

  setUp(() {
    repository = InMemoryHomeRepository();
  });

  group('InMemoryHomeRepository', () {
    group('getHomes()', () {
      test('returns initial homes', () async {
        final homes = await repository.getHomes();
        expect(homes.length, 2);
        expect(homes[0].name, 'Mountain Retreat');
        expect(homes[1].name, 'Urban Loft');
      });

      test('returns updated list after adding a home', () async {
        const newHome = Home(
          id: 0,
          name: 'Test Home',
          address: Address(
            street: '123 Test St',
            city: 'Test City',
            state: 'TS',
            zipCode: '12345',
          ),
        );
        await repository.addHome(newHome);

        final homes = await repository.getHomes();
        expect(homes.length, 3);
      });

      test('returns updated list after deleting a home', () async {
        await repository.deleteHome(1);

        final homes = await repository.getHomes();
        expect(homes.length, 1);
        expect(homes[0].id, 2);
      });

      test('returns empty list when all homes are deleted', () async {
        await repository.deleteHome(1);
        await repository.deleteHome(2);

        final homes = await repository.getHomes();
        expect(homes.isEmpty, true);
      });
    });

    group('getHomeById()', () {
      test('returns correct home', () async {
        final home = await repository.getHomeById(1);
        expect(home.id, 1);
        expect(home.name, 'Mountain Retreat');
        expect(home.address.city, 'Boulder');
      });

      test('throws exception for non-existent home', () async {
        expect(() => repository.getHomeById(999), throwsException);
      });

      test('returns home with updated information after update', () async {
        final originalHome = await repository.getHomeById(1);
        final updatedHome = originalHome.copyWith(name: 'Updated Home');
        await repository.updateHome(updatedHome);

        final home = await repository.getHomeById(1);
        expect(home.name, 'Updated Home');
      });
    });

    group('addHome()', () {
      test('adds a home with new ID', () async {
        const newHome = Home(
          id: 0, // This will be replaced
          name: 'Test Home',
          address: Address(
            street: '123 Test St',
            city: 'Test City',
            state: 'TS',
            zipCode: '12345',
          ),
          assets: [],
        );
        final result = await repository.addHome(newHome);
        expect(result.id, 3);
        expect(result.name, 'Test Home');

        final homes = await repository.getHomes();
        expect(homes.length, 3);
        expect(homes.any((h) => h.id == 3 && h.name == 'Test Home'), isTrue);
      });

      test('assigns incrementing IDs to multiple new homes', () async {
        const firstHome = Home(
          id: 0,
          name: 'First Home',
          address: Address(
            street: '123 First St',
            city: 'First City',
            state: 'FC',
            zipCode: '12345',
          ),
        );
        const secondHome = Home(
          id: 0,
          name: 'Second Home',
          address: Address(
            street: '456 Second St',
            city: 'Second City',
            state: 'SC',
            zipCode: '67890',
          ),
        );

        final resultFirst = await repository.addHome(firstHome);
        final resultSecond = await repository.addHome(secondHome);

        expect(resultFirst.id, 3);
        expect(resultSecond.id, 4);
      });

      test('preserves asset data when adding a home with assets', () async {
        const assetData = Asset(
          id: 100,
          name: 'Test Asset',
          category: 'Test Category',
          description: 'Test Description',
          manufacturer: 'Test Manufacturer',
        );

        const newHome = Home(
          id: 0,
          name: 'Asset Home',
          address: Address(
            street: '789 Asset St',
            city: 'Asset City',
            state: 'AC',
            zipCode: '13579',
          ),
          assets: [assetData],
        );

        final result = await repository.addHome(newHome);
        expect(result.assets.length, 1);
        expect(result.assets[0].name, 'Test Asset');
        expect(result.assets[0].manufacturer, 'Test Manufacturer');
      });
    });

    group('updateHome()', () {
      test('updates an existing home', () async {
        final originalHome = await repository.getHomeById(1);
        final updatedHome = originalHome.copyWith(
          name: 'Updated Mountain Retreat',
        );
        final result = await repository.updateHome(updatedHome);
        expect(result.id, 1);
        expect(result.name, 'Updated Mountain Retreat');

        final home = await repository.getHomeById(1);
        expect(home.name, 'Updated Mountain Retreat');
      });

      test('throws exception for non-existent home', () async {
        const nonExistentHome = Home(
          id: 999,
          name: 'Non-existent',
          address: Address(
            street: 'Nowhere',
            city: 'Nowhere',
            state: 'NO',
            zipCode: '00000',
          ),
        );
        expect(() => repository.updateHome(nonExistentHome), throwsException);
      });

      test('updates address information correctly', () async {
        final originalHome = await repository.getHomeById(1);
        final updatedHome = originalHome.copyWith(
          address: const Address(
            street: 'New Street',
            city: 'New City',
            state: 'NS',
            zipCode: '99999',
          ),
        );

        await repository.updateHome(updatedHome);
        final home = await repository.getHomeById(1);

        expect(home.address.street, 'New Street');
        expect(home.address.city, 'New City');
        expect(home.address.state, 'NS');
        expect(home.address.zipCode, '99999');
      });

      test('preserves assets when updating other properties', () async {
        final originalHome = await repository.getHomeById(1);
        final originalAssetCount = originalHome.assets.length;

        final updatedHome = originalHome.copyWith(name: 'New Name Only');
        await repository.updateHome(updatedHome);

        final home = await repository.getHomeById(1);
        expect(home.name, 'New Name Only');
        expect(home.assets.length, originalAssetCount);
      });
    });

    group('deleteHome()', () {
      test('removes a home', () async {
        await repository.deleteHome(1);
        final homes = await repository.getHomes();
        expect(homes.length, 1);
        expect(homes.any((h) => h.id == 1), isFalse);
        expect(() => repository.getHomeById(1), throwsException);
      });

      test('does nothing when deleting non-existent home', () async {
        await repository.deleteHome(999);
        final homes = await repository.getHomes();
        expect(homes.length, 2);
      });

      test('can delete all homes', () async {
        await repository.deleteHome(1);
        await repository.deleteHome(2);
        final homes = await repository.getHomes();
        expect(homes.isEmpty, true);
      });
    });

    group('addAssetToHome()', () {
      test('adds an asset to a home', () async {
        const newAsset = Asset(
          id: 100,
          name: 'Test Asset',
          category: 'Test',
          description: 'Test asset description',
        );
        await repository.addAssetToHome(1, newAsset);
        final home = await repository.getHomeById(1);
        expect(home.assets.length, 3);
        expect(home.assets.any((a) => a.id == 100 && a.name == 'Test Asset'),
            isTrue);
      });

      test('throws exception when home does not exist', () async {
        const newAsset = Asset(
          id: 100,
          name: 'Test Asset',
          category: 'Test',
          description: 'Test asset description',
        );
        expect(() => repository.addAssetToHome(999, newAsset), throwsException);
      });

      test('can add multiple assets to the same home', () async {
        const firstAsset = Asset(
          id: 101,
          name: 'First Asset',
          category: 'Test',
          description: 'First test asset',
        );
        const secondAsset = Asset(
          id: 102,
          name: 'Second Asset',
          category: 'Test',
          description: 'Second test asset',
        );

        await repository.addAssetToHome(1, firstAsset);
        await repository.addAssetToHome(1, secondAsset);

        final home = await repository.getHomeById(1);
        expect(home.assets.length, 4);
        expect(home.assets.any((a) => a.id == 101), isTrue);
        expect(home.assets.any((a) => a.id == 102), isTrue);
      });

      test('preserves existing assets when adding a new one', () async {
        final originalHome = await repository.getHomeById(1);
        final originalAssets = originalHome.assets;

        const newAsset = Asset(
          id: 103,
          name: 'New Asset',
          category: 'Test',
          description: 'New test asset',
        );

        await repository.addAssetToHome(1, newAsset);

        final updatedHome = await repository.getHomeById(1);
        for (final asset in originalAssets) {
          expect(updatedHome.assets.any((a) => a.id == asset.id), isTrue);
        }
      });
    });

    group('removeAssetFromHome()', () {
      test('removes an asset from a home', () async {
        final originalHome = await repository.getHomeById(1);
        final assetIdToRemove = originalHome.assets[0].id;
        await repository.removeAssetFromHome(1, assetIdToRemove);

        final updatedHome = await repository.getHomeById(1);
        expect(updatedHome.assets.length, originalHome.assets.length - 1);
        expect(updatedHome.assets.any((a) => a.id == assetIdToRemove), isFalse);
      });

      test('throws exception when home does not exist', () async {
        expect(() => repository.removeAssetFromHome(999, 1), throwsException);
      });

      test('does nothing when asset does not exist in home', () async {
        final originalHome = await repository.getHomeById(1);
        final originalAssetCount = originalHome.assets.length;

        await repository.removeAssetFromHome(1, 999);

        final updatedHome = await repository.getHomeById(1);
        expect(updatedHome.assets.length, originalAssetCount);
      });

      test('can remove all assets from a home', () async {
        final home = await repository.getHomeById(1);
        for (final asset in [...home.assets]) {
          await repository.removeAssetFromHome(1, asset.id);
        }

        final updatedHome = await repository.getHomeById(1);
        expect(updatedHome.assets.isEmpty, true);
      });

      test('only removes the specified asset', () async {
        final originalHome = await repository.getHomeById(1);
        final assetIdToRemove = originalHome.assets[0].id;
        final assetIdToKeep = originalHome.assets[1].id;

        await repository.removeAssetFromHome(1, assetIdToRemove);

        final updatedHome = await repository.getHomeById(1);
        expect(updatedHome.assets.any((a) => a.id == assetIdToRemove), isFalse);
        expect(updatedHome.assets.any((a) => a.id == assetIdToKeep), isTrue);
      });
    });

    group('getPredefinedAssets()', () {
      test('returns the list of predefined assets', () {
        final assets = repository.getPredefinedAssets();
        expect(assets.length, 8);
        expect(assets.any((a) => a.name == 'Central Air Conditioner'), isTrue);
        expect(assets.any((a) => a.name == 'Gas Furnace'), isTrue);
        expect(assets.any((a) => a.category == 'HVAC'), isTrue);
        expect(assets.any((a) => a.category == 'Appliance'), isTrue);
      });

      test('returns assets with correct properties', () {
        final assets = repository.getPredefinedAssets();
        final acUnit = assets.firstWhere(
          (a) => a.name == 'Central Air Conditioner',
        );

        expect(acUnit.id, 1);
        expect(acUnit.category, 'HVAC');
        expect(acUnit.manufacturer, 'Carrier');
        expect(acUnit.modelNumber, 'CC-2023-X');
      });

      test('returns a non-modifiable list', () {
        final assets1 = repository.getPredefinedAssets();
        final assets2 = repository.getPredefinedAssets();
        expect(identical(assets1, assets2), isTrue);
      });
    });
  });
}
