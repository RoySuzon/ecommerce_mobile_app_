import 'package:ecommerce_app/features/brand/domain/repository/brand_repository.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

class AddBrandUsecase {
  BrandRepository repo;
  AddBrandUsecase({
    required this.repo,
  });

  Future<Either<String, CommonModel>> call(CommonModel category) async =>
      repo.addBrand(category);
}
