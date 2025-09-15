import 'package:ecommerce_app/features/components/brand_dropdown/cubit/brand_cubit.dart';
import 'package:ecommerce_app/features/components/brand_dropdown/cubit/brand_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrandDropdown extends StatelessWidget {
  const BrandDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandCubit, BrandState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (message) => Center(child: Text('Error: $message')),
          success: (brands, selectedBrandId) {
            return DropdownButtonFormField<int>(
              value: selectedBrandId,
              hint: const Text('Select a brand'),
              items: brands.map((brand) {
                return DropdownMenuItem<int>(
                  value: brand.id,
                  child: Row(
                    children: [
                      Image.network(
                        brand.logoUrl,
                        width: 50,
                        height: 30,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => const Icon(
                          Icons.image_not_supported,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(brand.name),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) =>
                  context.read<BrandCubit>().selectBrand(value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
