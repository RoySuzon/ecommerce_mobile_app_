import 'dart:developer';

import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/features/category/presentations/providers/category_notifier.dart';
import 'package:ecommerce_app/features/category/presentations/states/category_state.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final categoryProvider = StateNotifierProvider<CategoryNotifier, CategoryState>(
  (ref) => CategoryNotifier(
    categoryGetUsecase: sl(),
    addCategoryUsecase: sl(),
  ),
);

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('Build');

    final state = ref.watch(categoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                // filter categories on input
                ref.read(categoryProvider.notifier).categories(name: value);
              },
              decoration: const InputDecoration(hintText: 'Search category'),
            ),
            Expanded(
              child: state.when(
                initial: () => const Center(child: Text('No categories')),
                loading: () => const Center(child: CircularProgressIndicator()),
                loaded: (categories) => ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return ListTile(title: Text(category.name ?? 'No Name'));
                  },
                ),
                error: (message) => Center(child: Text('Error: $message')),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          const newCategory = CategoryModel(name: 'New Cat');
          ref.read(categoryProvider.notifier).addCategory(newCategory);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
