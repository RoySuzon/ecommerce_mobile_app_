import 'package:ecommerce_app/features/category/domain/repository/category_repository.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

class AddCategoryUsecase {
  CategoryRepository repo;
  AddCategoryUsecase({
    required this.repo,
  });

  Future<Either<String, CategoryModel>> call(CategoryModel category) async =>
      repo.addCategory(category);
}
