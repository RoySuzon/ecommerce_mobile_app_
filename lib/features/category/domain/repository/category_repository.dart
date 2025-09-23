import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getBrand(String name);
  Future<Either<String, CategoryModel>> addBrand(CategoryModel category);
  Future<Either<String, CategoryModel>> updateCategory(CategoryModel category);
  Future<Either<String, CategoryModel>> deleteBrand(String id);
}
