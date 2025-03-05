import 'package:flutter_test/flutter_test.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';

void main() {
  group('Asset Model', () {
    test('creates an instance with required fields', () {
      const asset = Asset(
        id: 1,
        name: 'Test Asset',
        category: 'Test',
        description: 'Test asset description',
      );
      expect(asset.id, 1);
      expect(asset.name, 'Test Asset');
      expect(asset.category, 'Test');
      expect(asset.description, 'Test asset description');
      expect(asset.installationDate, isNull);
      expect(asset.lastServiceDate, isNull);
      expect(asset.manufacturer, isNull);
      expect(asset.modelNumber, isNull);
      expect(asset.serialNumber, isNull);
    });

    test('creates an instance with all fields', () {
      final installDate = DateTime(2024, 1, 1);
      final serviceDate = DateTime(2025, 1, 1);
      final asset = Asset(
        id: 1,
        name: 'Test Asset',
        category: 'Test',
        description: 'Test asset description',
        installationDate: installDate,
        lastServiceDate: serviceDate,
        manufacturer: 'Test Manufacturer',
        modelNumber: 'TM-2023',
        serialNumber: 'SN12345',
      );
      expect(asset.id, 1);
      expect(asset.name, 'Test Asset');
      expect(asset.category, 'Test');
      expect(asset.description, 'Test asset description');
      expect(asset.installationDate, installDate);
      expect(asset.lastServiceDate, serviceDate);
      expect(asset.manufacturer, 'Test Manufacturer');
      expect(asset.modelNumber, 'TM-2023');
      expect(asset.serialNumber, 'SN12345');
    });

    test('copyWith creates a new instance with updated properties', () {
      const originalAsset = Asset(
        id: 1,
        name: 'Original Asset',
        category: 'Original',
        description: 'Original description',
        manufacturer: 'Original Manufacturer',
      );
      final newInstallDate = DateTime(2023, 5, 15);
      final updatedAsset = originalAsset.copyWith(
        name: 'Updated Asset',
        installationDate: newInstallDate,
        modelNumber: 'NEW-2023',
      );
      expect(originalAsset.name, 'Original Asset');
      expect(originalAsset.installationDate, isNull);
      expect(updatedAsset.id, 1);
      expect(updatedAsset.name, 'Updated Asset');
      expect(updatedAsset.category, 'Original');
      expect(updatedAsset.description, 'Original description');
      expect(updatedAsset.installationDate, newInstallDate);
      expect(updatedAsset.manufacturer, 'Original Manufacturer');
      expect(updatedAsset.modelNumber, 'NEW-2023');
    });

    test('equality works correctly', () {
      const asset1 = Asset(
        id: 1,
        name: 'Test Asset',
        category: 'Test',
        description: 'Test asset description',
      );
      const asset2 = Asset(
        id: 1,
        name: 'Test Asset',
        category: 'Test',
        description: 'Test asset description',
      );
      const asset3 = Asset(
        id: 2,
        name: 'Test Asset',
        category: 'Test',
        description: 'Test asset description',
      );
      expect(asset1, equals(asset2));
      expect(asset1, isNot(equals(asset3)));
    });
  });
}
