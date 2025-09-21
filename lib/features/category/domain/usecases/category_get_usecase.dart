import 'package:ecommerce_app/features/category/domain/repository/category_repository.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

class CategoryGetUsecase {
  CategoryRepository repo;
  CategoryGetUsecase({
    required this.repo,
  });

  Future<Either<String, List<CategoryModel>>> call({String name = ''}) async =>
      repo.getCategories(name);
}
