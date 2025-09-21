import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.loaded(List<CategoryModel> categories) = _Loaded;
  const factory CategoryState.error(String message) = _Error;
}
