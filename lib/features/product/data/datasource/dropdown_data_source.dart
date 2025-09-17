import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/api/api_end_points.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';

abstract class DropdownDataSource {
  Future<List<BrandModel>> fetchBrands();
  Future<List<CategoryModel>> fetchCategories();
  Future<List<AvailabilityModel>> fetchAvailability();
  Future<List<CommonModel>> fetchCommonDropdown({
    required String type,
    String name,
  });
}

class DropdownRemoteDataSource implements DropdownDataSource {
  final Dio dio;
  DropdownRemoteDataSource({required this.dio});

  @override
  Future<List<BrandModel>> fetchBrands({String name = ''}) async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.brand,
      queryParameters: {'name': name},
    );
    return (response.data['data'] as List)
        .map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<CategoryModel>> fetchCategories({String name = ''}) async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.category,
      queryParameters: {'name': name},
    );
    return (response.data['data'] as List)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AvailabilityModel>> fetchAvailability({String name = ''}) async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.dropdown,
      queryParameters: {'type': 'availability', name: name},
    );
    return (response.data['data'] as List)
        .map((e) => AvailabilityModel(status: e.toString()))
        .toList();
  }

  @override
  Future<List<CommonModel>> fetchCommonDropdown({
    required String type,
    String name = '',
  }) async {
    final response = await dio.get<dynamic>(
      ApiEndPoints.dropdown,
      queryParameters: {'type': type, 'name': name},
    );
    return (response.data['data'] as List)
        .map((e) => CommonModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
