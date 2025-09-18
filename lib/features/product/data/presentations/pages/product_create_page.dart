import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/features/product/data/datasource/dropdown_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:ecommerce_app/features/widgets/custom_textfield.dart';
import 'package:ecommerce_app/features/widgets/specification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCreatePage extends StatelessWidget {
  const ProductCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    var specifications = <Specification>[];
    const availableKeys = [
      'Brand',
      'Model',
      'Color',
      'Weight',
      'Dimensions',
      'Warranty',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: nameController,
                  title: 'Product Name',
                  label: 'Enter Product Name',
                  maxLines: 2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),
                CustomTextFormField(
                  controller: descriptionController,
                  title: 'Product Description',
                  label: 'Enter Product Description',
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<CommonModel>.searchRequest(
                        searchRequestLoadingIndicator: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        hintBuilder: (context, hint, enabled) => Text(hint),
                        futureRequest: (req) => DropdownRemoteDataSource(
                          dio: sl<Dio>(),
                        ).fetchCommonDropdown(type: 'brand', name: req.trim()),
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) =>
                                customBarTextWithLogo(
                                  title: item.name ?? '',
                                  logoUrl: item.logoUrl,
                                ),
                        headerBuilder: (context, selectedItem, enabled) =>
                            customBarTextWithLogo(
                              title: selectedItem.name ?? '',
                              logoUrl: selectedItem.logoUrl,
                            ),
                        hintText: 'Brand',
                        onChanged: (value) {
                          log('changing value to: ${value!.id}');
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDropdown<CommonModel>.searchRequest(
                        searchRequestLoadingIndicator: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        hintBuilder: (context, hint, enabled) => Text(hint),
                        futureRequest: (req) =>
                            DropdownRemoteDataSource(
                              dio: sl<Dio>(),
                            ).fetchCommonDropdown(
                              type: 'category',
                              name: req.trim(),
                            ),
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) =>
                                customBarTextWithLogo(
                                  title: item.name ?? '',
                                  logoUrl: item.logoUrl,
                                ),
                        headerBuilder: (context, selectedItem, enabled) =>
                            customBarTextWithLogo(
                              title: selectedItem.name ?? '',
                            ),
                        hintText: 'Category',
                        onChanged: (value) {
                          log('changing value to: ${value!.id}');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown<CommonModel>.searchRequest(
                        searchRequestLoadingIndicator: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        hintBuilder: (context, hint, enabled) => Text(hint),
                        futureRequest: (req) =>
                            DropdownRemoteDataSource(
                              dio: sl<Dio>(),
                            ).fetchCommonDropdown(
                              type: 'availability',
                              name: req.trim(),
                            ),
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) =>
                                customBarTextWithLogo(
                                  title: item.name ?? '',
                                  logoUrl: item.logoUrl,
                                ),
                        headerBuilder: (context, selectedItem, enabled) =>
                            customBarTextWithLogo(
                              title: selectedItem.name ?? '',
                              logoUrl: selectedItem.logoUrl,
                            ),
                        hintText: 'availability',
                        onChanged: (value) {
                          log('changing value to: ${value!.name}');
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomDropdown<CommonModel>.searchRequest(
                        searchRequestLoadingIndicator: const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        hintBuilder: (context, hint, enabled) => Text(
                          hint,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        futureRequest: (req) =>
                            DropdownRemoteDataSource(
                              dio: sl<Dio>(),
                            ).fetchCommonDropdown(
                              type: 'specificationType',
                              name: req.trim(),
                            ),
                        listItemBuilder:
                            (context, item, isSelected, onItemSelect) =>
                                customBarTextWithLogo(
                                  title: item.name ?? '',
                                  logoUrl: item.logoUrl,
                                ),
                        headerBuilder: (context, selectedItem, enabled) =>
                            customBarTextWithLogo(
                              title: selectedItem.name ?? '',
                            ),
                        hintText: 'SpecificationType',
                        onChanged: (value) {
                          log('changing value to: ${value!.id}');
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                DynamicSpecifications(
                  availableKeys: availableKeys,
                  onSpecificationsChanged: (specification) {
                    specifications = specification;
                    log(specification.toString());
                  },
                ),

                const SizedBox(height: 10),

                /// 🔹 Log Button
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // log('Brand: ${brand?.name}');
                      // log('Category: ${category?.name}');
                      // log('Availability: ${availability?.status}');
                      // log("Timescale: ${timescale?['label']}");

                      final body = {
                        'name': 'any',
                        'model': 'any',
                        'description': 'any',
                        'deliveryTimescale': 'any',
                        'specifications': specifications
                            .map((e) => e.toJson())
                            .toList(),
                        'brandId': 'any',
                        'categoryId': 'any',
                        'availabilityId': 'any',
                      };

                      log(body.toString());
                    }
                  },
                  child: const Text('LOG SELECTED VALUES'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Row customBarTextWithLogo({required String title, String? logoUrl}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
        ),
      ),
      if (logoUrl != null)
        CachedNetworkImage(
          imageUrl: logoUrl,
          height: 15,
          width: 30,
          fit: BoxFit.contain,

          placeholder: (context, url) => const CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
    ],
  );
}
