import 'package:ecommerce_app/features/brand/data/datasources/brand_data_source.dart';
import 'package:ecommerce_app/features/brand/domain/repository/brand_repository.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandDataSource dataSource;
  BrandRepositoryImpl(this.dataSource);
  @override
  Future<Either<String, CommonModel>> addBrand(
    CommonModel brand,
  ) async => dataSource.insertBrand(brand);

  @override
  Future<Either<String, CommonModel>> deleteBrand(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<CommonModel>>> getBrand(
    String name,
  ) async => await dataSource.fetchBrand(name);

  @override
  Future<Either<String, CommonModel>> updateBrand(CommonModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
