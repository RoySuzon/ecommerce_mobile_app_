import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

abstract class BrandRepository {
  Future<Either<String, List<CommonModel>>> getBrand(String name);
  Future<Either<String, CommonModel>> addBrand(CommonModel brand);
  Future<Either<String, CommonModel>> updateBrand(CommonModel category);
  Future<Either<String, CommonModel>> deleteBrand(String id);
}
