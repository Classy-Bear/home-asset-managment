import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

/// A model representing a physical asset within a home.
///
/// Assets can be appliances, HVAC systems, electronics, or other items that
/// users want to track and manage as part of their home inventory.
@freezed
class Asset with _$Asset {
  const factory Asset({
    /// Unique identifier for the asset.
    required int id,

    /// Name of the asset (e.g., "Refrigerator", "Furnace").
    required String name,

    /// Category the asset belongs to (e.g., "Appliance", "HVAC").
    required String category,

    /// Detailed description of the asset.
    required String description,

    /// Date when the asset was installed.
    DateTime? installationDate,

    /// Date when the asset was last serviced.
    DateTime? lastServiceDate,

    /// Company that manufactured the asset.
    String? manufacturer,

    /// Model number of the asset.
    String? modelNumber,

    /// Serial number of the asset.
    String? serialNumber,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}
