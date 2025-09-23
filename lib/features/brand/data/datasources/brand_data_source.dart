import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/api/api_end_points.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

abstract class BrandDataSource {
  FutureOr<Either<String, List<CommonModel>>> fetchBrand(String name);
  FutureOr<Either<String, CommonModel>> insertBrand(
    CommonModel brand,
  );
  FutureOr<Either<String, CommonModel>> updateBrand(
    CommonModel brand,
  );
}

class BrandDataSourceImp implements BrandDataSource {
  final Dio dio;
  BrandDataSourceImp({
    required this.dio,
  });
  @override
  FutureOr<Either<String, List<CommonModel>>> fetchBrand(
    String name,
  ) async {
    try {
      final response = await dio.get<dynamic>(
        ApiEndPoints.brand,
        queryParameters: {'name': name},
      );

      if (response.statusCode == 200) {
        final categories = (response.data['data'] as List)
            .map(
              (e) => CommonModel.fromJson(e as Map<String, dynamic>),
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
  FutureOr<Either<String, CommonModel>> insertBrand(
    CommonModel brand,
  ) async {
    try {
      final response = await dio.post<dynamic>(
        ApiEndPoints.brand,
        data: brand.toJson(),
      );

      if (response.statusCode == 201) {
        final category = CommonModel.fromJson(
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
  FutureOr<Either<String, CommonModel>> updateBrand(
    CommonModel brand,
  ) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
