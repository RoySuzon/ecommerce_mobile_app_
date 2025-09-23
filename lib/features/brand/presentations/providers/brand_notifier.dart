import 'package:ecommerce_app/features/brand/domain/usecases/add_brand_usecase.dart';
import 'package:ecommerce_app/features/brand/domain/usecases/brand_get_usecase.dart';
import 'package:ecommerce_app/features/brand/presentations/states/brand_state.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:flutter_riverpod/legacy.dart';

class BrandNotifier extends StateNotifier<BrandState> {
  final BrandGetUsecase brandGetUsecase;
  final AddBrandUsecase addBrandUsecase;
  BrandNotifier({
    required this.brandGetUsecase,
    required this.addBrandUsecase,
  }) : super(const BrandState.initial()) {
    brands();
  }

  Future<void> brands({String name = ''}) async {
    state = const BrandState.loading();
    final result = await brandGetUsecase(name: name);
    if (!mounted) return;
    state = result.fold(BrandState.error, BrandState.loaded);
  }

  Future<void> addBrand(CommonModel brand) async {
    final oldCategories = state.whenOrNull(loaded: (brands) => brands);
    state = const BrandState.loading();
    final result = await addBrandUsecase(brand);
    if (!mounted) return;
    state = result.fold(
      BrandState.error,
      (newCategory) => BrandState.loaded([newCategory, ...oldCategories ?? []]),
    );
  }
}
