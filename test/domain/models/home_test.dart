import 'package:flutter_test/flutter_test.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';

void main() {
  group('Home Model', () {
    test('creates a instance with required fields', () {
      const home = Home(
        id: 1,
        name: 'Test Home',
        address: Address(
          street: '123 Test St',
          city: 'Test City',
          state: 'TS',
          zipCode: '12345',
        ),
      );
      expect(home.id, 1);
      expect(home.name, 'Test Home');
      expect(home.address.street, '123 Test St');
      expect(home.assets, isEmpty);
    });

    test('creates a instance with assets', () {
      const asset = Asset(
        id: 1,
        name: 'Test Asset',
        category: 'Test',
        description: 'Test asset description',
      );
      const home = Home(
        id: 1,
        name: 'Test Home',
        address: Address(
          street: '123 Test St',
          city: 'Test City',
          state: 'TS',
          zipCode: '12345',
        ),
        assets: [asset],
      );
      expect(home.assets.length, 1);
      expect(home.assets.first.name, 'Test Asset');
    });

    test('copyWith creates a new instance with updated properties', () {
      const originalHome = Home(
        id: 1,
        name: 'Original Home',
        address: Address(
          street: '123 Original St',
          city: 'Original City',
          state: 'OG',
          zipCode: '12345',
        ),
      );
      const newAddress = Address(
        street: '456 New St',
        city: 'New City',
        state: 'NEW',
        zipCode: '67890',
      );
      final updatedHome = originalHome.copyWith(
        name: 'Updated Home',
        address: newAddress,
      );
      expect(originalHome.name, 'Original Home');
      expect(originalHome.address.city, 'Original City');
      expect(updatedHome.id, 1);
      expect(updatedHome.name, 'Updated Home');
      expect(updatedHome.address.street, '456 New St');
      expect(updatedHome.address.city, 'New City');
    });

    // We'll skip the toJson/fromJson test since the freezed_annotation library
    // handles the serialization and the model is already tested in widget tests
  });

  group('Address Model', () {
    test('creates an instance with required fields', () {
      const address = Address(
        street: '123 Test St',
        city: 'Test City',
        state: 'TS',
        zipCode: '12345',
      );
      expect(address.street, '123 Test St');
      expect(address.city, 'Test City');
      expect(address.state, 'TS');
      expect(address.zipCode, '12345');
    });

    test('formattedAddress returns correctly formatted address string', () {
      const address = Address(
        street: '123 Test St',
        city: 'Test City',
        state: 'TS',
        zipCode: '12345',
      );
      expect(address.formattedAddress, '123 Test St, Test City, TS 12345');
    });

    test('copyWith creates a new instance with updated properties', () {
      const originalAddress = Address(
        street: '123 Original St',
        city: 'Original City',
        state: 'OG',
        zipCode: '12345',
      );
      final updatedAddress = originalAddress.copyWith(
        street: '456 New St',
        city: 'New City',
      );
      expect(originalAddress.street, '123 Original St');
      expect(originalAddress.city, 'Original City');
      expect(updatedAddress.street, '456 New St');
      expect(updatedAddress.city, 'New City');
      expect(updatedAddress.state, 'OG');
      expect(updatedAddress.zipCode, '12345');
    });

    // We'll skip the toJson/fromJson test for Address as well
  });
}
