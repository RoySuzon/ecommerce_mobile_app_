import 'package:ecommerce_app/features/brand/domain/repository/brand_repository.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:fpdart/fpdart.dart';

class BrandGetUsecase {
  BrandRepository repo;
  BrandGetUsecase({
    required this.repo,
  });

  Future<Either<String, List<CommonModel>>> call({String name = ''}) async =>
      repo.getBrand(name);
}
