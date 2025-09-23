import 'package:ecommerce_app/features/category/domain/usecases/add_category_usecase.dart';
import 'package:ecommerce_app/features/category/domain/usecases/category_get_usecase.dart';
import 'package:ecommerce_app/features/category/presentations/states/category_state.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:flutter_riverpod/legacy.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryGetUsecase categoryGetUsecase;
  final AddCategoryUsecase addCategoryUsecase;
  CategoryNotifier({
    required this.categoryGetUsecase,
    required this.addCategoryUsecase,
  }) : super(const CategoryState.initial()) {
    categories();
  }

  Future<void> categories({String name = ''}) async {
    state = const CategoryState.loading();
    final result = await categoryGetUsecase(name: name);
    if (!mounted) return;
    state = result.fold(CategoryState.error, CategoryState.loaded);
  }

  Future<void> addCategory(CategoryModel category) async {
    final oldCategories = state.whenOrNull(loaded: (categories) => categories);
    state = const CategoryState.loading();
    final result = await addCategoryUsecase(category);
    if (!mounted) return;
    state = result.fold(
      CategoryState.error,
      (newCategory) =>
          CategoryState.loaded([newCategory, ...oldCategories ?? []]),
    );
  }
}
