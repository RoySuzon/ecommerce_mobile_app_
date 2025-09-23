import 'dart:developer';

import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/features/category/presentations/providers/category_notifier.dart';
import 'package:ecommerce_app/features/category/presentations/states/category_state.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:ecommerce_app/features/widgets/debounch_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final StateNotifierProvider<CategoryNotifier, CategoryState> categoryProvider =
    StateNotifierProvider.autoDispose<CategoryNotifier, CategoryState>(
      (ref) =>
          CategoryNotifier(categoryGetUsecase: sl(), addCategoryUsecase: sl()),
    );

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Categories')),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              // Consumer(
              //   builder: (context, ref, child) {
              //     log('Build Counter Widget');
              //     final count = ref.watch(counterProvider);
              //     return Text('$count');
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomSearchBar(
                  // debounceMilliseconds: 1000,
                  placeholder: 'Search Category',
                  onSearch: (ref, value) => ref
                      .read(categoryProvider.notifier)
                      .categories(name: value.trim()),
                ),
              ),

              Consumer(
                builder: (context, ref, child) {
                  log('Build the Category List widgets');
                  final state = ref.watch(categoryProvider);
                  return Expanded(
                    child: state.when(
                      initial: () => const Center(child: Text('No categories')),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      loaded: (categories) => ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return ListTile(
                            title: Text(category.name ?? 'No Name'),
                          );
                        },
                      ),
                      error: (message) =>
                          Center(child: Text('Error: $message')),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Consumer(
        builder: (context, ref, child) => FloatingActionButton(
          onPressed: () {
            final controller = TextEditingController();
            final formKey = GlobalKey<FormState>();
            showCupertinoDialog<dynamic>(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('Enter Name'),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            // style: TextFieldStyle.cupertino,
                            controller: controller,
                            placeholder: 'Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length < 3) {
                                return 'Name too short';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      child: const Text('Insert'),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final name = controller.text;
                          if (kDebugMode) {
                            print('Name entered: $name');
                          }
                          ref
                              .read(categoryProvider.notifier)
                              .addCategory(CategoryModel(name: name));

                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
