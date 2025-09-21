import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/api/api_end_points.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryDataSource {
  FutureOr<Either<String, List<CategoryModel>>> fetchCategory(String name);
  FutureOr<Either<String, CategoryModel>> insertCategory(
    CategoryModel category,
  );
  FutureOr<Either<String, CategoryModel>> updateCategory(
    CategoryModel category,
  );
}

class CategoryDataSourceImp implements CategoryDataSource {
  final Dio dio;
  CategoryDataSourceImp({
    required this.dio,
  });
  @override
  FutureOr<Either<String, List<CategoryModel>>> fetchCategory(
    String name,
  ) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndPoints.category,
        queryParameters: {'name': name},
      );

      if (response.statusCode == 200) {
        final categories = (response.data['data'] as List)
            .map(
              (e) => CategoryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
        return Right(categories);
      } else {
        return Left(response.data['message'].toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  FutureOr<Either<String, CategoryModel>> insertCategory(
    CategoryModel category,
  ) async {
    try {
      final response = await dio.post<dynamic>(
        ApiEndPoints.category,
        data: category.toJson(),
      );

      if (response.statusCode == 201) {
        final category = CategoryModel.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
        return Right(category);
      } else {
        return Left(response.data['message'].toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  FutureOr<Either<String, CategoryModel>> updateCategory(
    CategoryModel category,
  ) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
