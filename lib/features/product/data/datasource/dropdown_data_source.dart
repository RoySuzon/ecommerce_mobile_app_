import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/api/api_end_points.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';

abstract class DropdownDataSource {
  Future<List<BrandModel>> fetchBrands();
  Future<List<CategoryModel>> fetchCategories();
  Future<List<AvailabilityModel>> fetchAvailability();
  Future<List<CommonModel>> fetchCommonDropdown(String type);
}

class DropdownRemoteDataSource implements DropdownDataSource {
  final Dio dio;
  DropdownRemoteDataSource({required this.dio});

  @override
  Future<List<BrandModel>> fetchBrands() async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.dropdown,
      queryParameters: {'type': 'brand'},
    );
    return (response.data['data'] as List)
        .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.category,
      queryParameters: {'type': 'category'},
    );
    return (response.data['data'] as List)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AvailabilityModel>> fetchAvailability() async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.dropdown,
      queryParameters: {'type': 'availability'},
    );
    return (response.data['data'] as List)
        .map((e) => AvailabilityModel(status: e.toString()))
        .toList();
  }

  @override
  Future<List<CommonModel>> fetchCommonDropdown(String type) async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.dropdown,
      queryParameters: {'type': type},
    );
    return (response.data['data'] as List)
        .map((e) => CommonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
