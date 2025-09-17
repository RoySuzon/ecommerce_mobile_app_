import 'package:freezed_annotation/freezed_annotation.dart';

part 'dropdown_models.freezed.dart';
part 'dropdown_models.g.dart';

@freezed
sealed class BrandModel with _$BrandModel {
  const factory BrandModel({
    required int id,
    required String name,
    String? logoUrl,
  }) = _BrandModel;

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);
}

@freezed
sealed class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    required int id,
    required String name,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
sealed class AvailabilityModel with _$AvailabilityModel {
  const factory AvailabilityModel({
    // required int id,
    required String status,
  }) = _AvailabilityModel;

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityModelFromJson(json);
}

@freezed
sealed class CommonModel with _$CommonModel {
  const factory CommonModel({
    String? name,
    num? id,
    String? url,
    String? logoUrl,
    String? description,
    String? type,
    String? field,
    String? value,
  }) = _CommonModel;

  factory CommonModel.fromJson(Map<String, dynamic> json) =>
      _$CommonModelFromJson(json);
}
