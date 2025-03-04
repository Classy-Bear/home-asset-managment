import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
class Asset with _$Asset {
  const factory Asset({
    required int id,
    required String name,
    required String category,
    required String description,
    DateTime? installationDate,
    DateTime? lastServiceDate,
    String? manufacturer,
    String? modelNumber,
    String? serialNumber,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}
