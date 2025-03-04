import 'package:freezed_annotation/freezed_annotation.dart';
import '../asset/asset.dart';

part 'home.freezed.dart';
part 'home.g.dart';

@freezed
class Home with _$Home {
  const factory Home({
    required int id,
    required String name,
    required Address address,
    @Default([]) List<Asset> assets,
  }) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}

@freezed
class Address with _$Address {
  const factory Address({
    required String street,
    required String city,
    required String state,
    required String zipCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  const Address._();
  String get formattedAddress => '$street, $city, $state $zipCode';
}
