import 'package:freezed_annotation/freezed_annotation.dart';
import '../asset/asset.dart';

part 'home.freezed.dart';
part 'home.g.dart';

/// A model representing a residential property managed by the application.
///
/// Homes contain basic information like name and address, and can have
/// multiple associated assets.
@freezed
class Home with _$Home {
  const factory Home({
    /// Unique identifier for the home.
    required int id,

    /// Descriptive name of the home (e.g., "Main Residence", "Vacation Home").
    required String name,

    /// Physical location details of the home.
    required Address address,

    /// Collection of assets associated with this home.
    @Default([]) List<Asset> assets,
  }) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}

/// A model representing a physical address of a home.
///
/// Contains all components needed for a complete US mailing address.
@freezed
class Address with _$Address {
  const factory Address({
    /// Street number and name (e.g., "123 Main St").
    required String street,

    /// City name.
    required String city,

    /// State name or abbreviation.
    required String state,

    /// US ZIP code.
    required String zipCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  const Address._();

  /// Returns a formatted string of the complete address.
  String get formattedAddress => '$street, $city, $state $zipCode';
}
