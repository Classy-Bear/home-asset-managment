// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return _Asset.fromJson(json);
}

/// @nodoc
mixin _$Asset {
  /// Unique identifier for the asset.
  int get id => throw _privateConstructorUsedError;

  /// Name of the asset (e.g., "Refrigerator", "Furnace").
  String get name => throw _privateConstructorUsedError;

  /// Category the asset belongs to (e.g., "Appliance", "HVAC").
  String get category => throw _privateConstructorUsedError;

  /// Detailed description of the asset.
  String get description => throw _privateConstructorUsedError;

  /// Date when the asset was installed.
  DateTime? get installationDate => throw _privateConstructorUsedError;

  /// Date when the asset was last serviced.
  DateTime? get lastServiceDate => throw _privateConstructorUsedError;

  /// Company that manufactured the asset.
  String? get manufacturer => throw _privateConstructorUsedError;

  /// Model number of the asset.
  String? get modelNumber => throw _privateConstructorUsedError;

  /// Serial number of the asset.
  String? get serialNumber => throw _privateConstructorUsedError;

  /// Serializes this Asset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssetCopyWith<Asset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res, Asset>;
  @useResult
  $Res call(
      {int id,
      String name,
      String category,
      String description,
      DateTime? installationDate,
      DateTime? lastServiceDate,
      String? manufacturer,
      String? modelNumber,
      String? serialNumber});
}

/// @nodoc
class _$AssetCopyWithImpl<$Res, $Val extends Asset>
    implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? description = null,
    Object? installationDate = freezed,
    Object? lastServiceDate = freezed,
    Object? manufacturer = freezed,
    Object? modelNumber = freezed,
    Object? serialNumber = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      installationDate: freezed == installationDate
          ? _value.installationDate
          : installationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastServiceDate: freezed == lastServiceDate
          ? _value.lastServiceDate
          : lastServiceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      modelNumber: freezed == modelNumber
          ? _value.modelNumber
          : modelNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssetImplCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$$AssetImplCopyWith(
          _$AssetImpl value, $Res Function(_$AssetImpl) then) =
      __$$AssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String category,
      String description,
      DateTime? installationDate,
      DateTime? lastServiceDate,
      String? manufacturer,
      String? modelNumber,
      String? serialNumber});
}

/// @nodoc
class __$$AssetImplCopyWithImpl<$Res>
    extends _$AssetCopyWithImpl<$Res, _$AssetImpl>
    implements _$$AssetImplCopyWith<$Res> {
  __$$AssetImplCopyWithImpl(
      _$AssetImpl _value, $Res Function(_$AssetImpl) _then)
      : super(_value, _then);

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? description = null,
    Object? installationDate = freezed,
    Object? lastServiceDate = freezed,
    Object? manufacturer = freezed,
    Object? modelNumber = freezed,
    Object? serialNumber = freezed,
  }) {
    return _then(_$AssetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      installationDate: freezed == installationDate
          ? _value.installationDate
          : installationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastServiceDate: freezed == lastServiceDate
          ? _value.lastServiceDate
          : lastServiceDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      modelNumber: freezed == modelNumber
          ? _value.modelNumber
          : modelNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      serialNumber: freezed == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetImpl implements _Asset {
  const _$AssetImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.description,
      this.installationDate,
      this.lastServiceDate,
      this.manufacturer,
      this.modelNumber,
      this.serialNumber});

  factory _$AssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetImplFromJson(json);

  /// Unique identifier for the asset.
  @override
  final int id;

  /// Name of the asset (e.g., "Refrigerator", "Furnace").
  @override
  final String name;

  /// Category the asset belongs to (e.g., "Appliance", "HVAC").
  @override
  final String category;

  /// Detailed description of the asset.
  @override
  final String description;

  /// Date when the asset was installed.
  @override
  final DateTime? installationDate;

  /// Date when the asset was last serviced.
  @override
  final DateTime? lastServiceDate;

  /// Company that manufactured the asset.
  @override
  final String? manufacturer;

  /// Model number of the asset.
  @override
  final String? modelNumber;

  /// Serial number of the asset.
  @override
  final String? serialNumber;

  @override
  String toString() {
    return 'Asset(id: $id, name: $name, category: $category, description: $description, installationDate: $installationDate, lastServiceDate: $lastServiceDate, manufacturer: $manufacturer, modelNumber: $modelNumber, serialNumber: $serialNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.installationDate, installationDate) ||
                other.installationDate == installationDate) &&
            (identical(other.lastServiceDate, lastServiceDate) ||
                other.lastServiceDate == lastServiceDate) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.modelNumber, modelNumber) ||
                other.modelNumber == modelNumber) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      category,
      description,
      installationDate,
      lastServiceDate,
      manufacturer,
      modelNumber,
      serialNumber);

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      __$$AssetImplCopyWithImpl<_$AssetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetImplToJson(
      this,
    );
  }
}

abstract class _Asset implements Asset {
  const factory _Asset(
      {required final int id,
      required final String name,
      required final String category,
      required final String description,
      final DateTime? installationDate,
      final DateTime? lastServiceDate,
      final String? manufacturer,
      final String? modelNumber,
      final String? serialNumber}) = _$AssetImpl;

  factory _Asset.fromJson(Map<String, dynamic> json) = _$AssetImpl.fromJson;

  /// Unique identifier for the asset.
  @override
  int get id;

  /// Name of the asset (e.g., "Refrigerator", "Furnace").
  @override
  String get name;

  /// Category the asset belongs to (e.g., "Appliance", "HVAC").
  @override
  String get category;

  /// Detailed description of the asset.
  @override
  String get description;

  /// Date when the asset was installed.
  @override
  DateTime? get installationDate;

  /// Date when the asset was last serviced.
  @override
  DateTime? get lastServiceDate;

  /// Company that manufactured the asset.
  @override
  String? get manufacturer;

  /// Model number of the asset.
  @override
  String? get modelNumber;

  /// Serial number of the asset.
  @override
  String? get serialNumber;

  /// Create a copy of Asset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssetImplCopyWith<_$AssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
