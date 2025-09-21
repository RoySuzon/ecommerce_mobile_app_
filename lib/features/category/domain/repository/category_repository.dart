import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getCategories(String name);
  Future<Either<String, CategoryModel>> addCategory(CategoryModel category);
  Future<Either<String, CategoryModel>> updateCategory(CategoryModel category);
  Future<Either<String, CategoryModel>> deleteCategory(String id);
}
