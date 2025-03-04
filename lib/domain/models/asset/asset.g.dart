// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssetImpl _$$AssetImplFromJson(Map<String, dynamic> json) => _$AssetImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      installationDate: json['installationDate'] == null
          ? null
          : DateTime.parse(json['installationDate'] as String),
      lastServiceDate: json['lastServiceDate'] == null
          ? null
          : DateTime.parse(json['lastServiceDate'] as String),
      manufacturer: json['manufacturer'] as String?,
      modelNumber: json['modelNumber'] as String?,
      serialNumber: json['serialNumber'] as String?,
    );

Map<String, dynamic> _$$AssetImplToJson(_$AssetImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'installationDate': instance.installationDate?.toIso8601String(),
      'lastServiceDate': instance.lastServiceDate?.toIso8601String(),
      'manufacturer': instance.manufacturer,
      'modelNumber': instance.modelNumber,
      'serialNumber': instance.serialNumber,
    };
