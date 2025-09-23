import 'package:ecommerce_app/features/category/data/datasources/category_data_source.dart';
import 'package:ecommerce_app/features/category/domain/repository/category_repository.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDataSource dataSource;
  CategoryRepositoryImpl(this.dataSource);
  @override
  Future<Either<String, CategoryModel>> addBrand(
    CategoryModel category,
  ) async => dataSource.insertCategory(category);

  @override
  Future<Either<String, CategoryModel>> deleteBrand(String id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<CategoryModel>>> getBrand(
    String name,
  ) async => await dataSource.fetchCategory(name);

  @override
  Future<Either<String, CategoryModel>> updateCategory(CategoryModel category) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
}
