import 'package:ecommerce_app/features/product/data/datasource/dropdown_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'brand_state.dart';

class BrandCubit extends Cubit<BrandState> {
  final DropdownRemoteDataSource dataSource;

  BrandCubit(this.dataSource) : super(const BrandState.initial());

  Future<void> loadBrands() async {
    emit(const BrandState.loading());
    try {
      final brands = await dataSource.fetchBrands();
      emit(BrandState.success(brands: brands));
    } catch (e) {
      emit(BrandState.failure(e.toString()));
    }
  }

  void selectBrand(int? brandId) {
    state.maybeWhen(
      success: (brands, _) {
        emit(BrandState.success(brands: brands, selectedBrandId: brandId));
      },
      orElse: () {},
    );
  }
}
