// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => _BrandModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String,
);

Map<String, dynamic> _$BrandModelToJson(_BrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logoUrl': instance.logoUrl,
    };

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

_AvailabilityModel _$AvailabilityModelFromJson(Map<String, dynamic> json) =>
    _AvailabilityModel(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AvailabilityModelToJson(_AvailabilityModel instance) =>
    <String, dynamic>{'id': instance.id, 'status': instance.status};
