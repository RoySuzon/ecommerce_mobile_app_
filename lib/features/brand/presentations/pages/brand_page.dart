import 'dart:developer';

import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/features/brand/presentations/providers/brand_notifier.dart';
import 'package:ecommerce_app/features/brand/presentations/states/brand_state.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:ecommerce_app/features/widgets/debounch_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final StateNotifierProvider<BrandNotifier, BrandState> brandProvider =
    StateNotifierProvider.autoDispose<BrandNotifier, BrandState>(
      (ref) => BrandNotifier(brandGetUsecase: sl(), addBrandUsecase: sl()),
    );

class BrandPage extends StatelessWidget {
  const BrandPage({super.key});

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
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        // debounceMilliseconds: 1000,
                        placeholder: 'Search brand',
                        onSearch: (ref, value) => ref
                            .read(brandProvider.notifier)
                            .brands(name: value.trim()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Consumer(
                      builder: (context, ref, child) => TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          foregroundColor: Colors.white,
                        ),
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
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
                                            .read(brandProvider.notifier)
                                            .addBrand(CommonModel(name: name));

                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add'),
                      ),
                    ),
                  ],
                ),
              ),

              Consumer(
                builder: (context, ref, child) {
                  log('Build the Category List widgets');
                  final state = ref.watch(brandProvider);
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
                            onTap: () {
                              log('Tapped on ${category.logoUrl}');
                            },
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
    );
  }
}
