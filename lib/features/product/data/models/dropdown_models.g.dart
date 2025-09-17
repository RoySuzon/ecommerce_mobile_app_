// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dropdown_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => _BrandModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String?,
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
    _AvailabilityModel(status: json['status'] as String);

Map<String, dynamic> _$AvailabilityModelToJson(_AvailabilityModel instance) =>
    <String, dynamic>{'status': instance.status};

_CommonModel _$CommonModelFromJson(Map<String, dynamic> json) => _CommonModel(
  name: json['name'] as String?,
  id: json['id'] as num?,
  url: json['url'] as String?,
  logoUrl: json['logoUrl'] as String?,
  description: json['description'] as String?,
  type: json['type'] as String?,
  field: json['field'] as String?,
  value: json['value'] as String?,
);

Map<String, dynamic> _$CommonModelToJson(_CommonModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'url': instance.url,
      'logoUrl': instance.logoUrl,
      'description': instance.description,
      'type': instance.type,
      'field': instance.field,
      'value': instance.value,
    };
