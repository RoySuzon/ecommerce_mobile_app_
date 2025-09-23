import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand_state.freezed.dart';

@freezed
class BrandState with _$BrandState {
  const factory BrandState.initial() = _Initial;
  const factory BrandState.loading() = _Loading;
  const factory BrandState.loaded(List<CommonModel> brands) = _Loaded;
  const factory BrandState.error(String message) = _Error;
}
