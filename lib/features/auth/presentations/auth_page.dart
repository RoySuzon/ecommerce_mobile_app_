import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_app/features/components/generic_dropdown/cubit/dropdown_bloc.dart';
import 'package:ecommerce_app/features/components/generic_dropdown/cubit/dropdown_state.dart';
import 'package:ecommerce_app/features/components/generic_dropdown/view/generic_dropdown_view.dart';
import 'package:ecommerce_app/features/product/data/models/dropdown_models.dart';
import 'package:ecommerce_app/features/widgets/custom_textfield.dart';
import 'package:ecommerce_app/features/widgets/specification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _formKey = GlobalKey<FormState>();

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _descriptionController = TextEditingController();
    List<Specification> specifications = [];

    List<CommonModel> specifics = [];

    const availableKeys = [
      // General
      'Brand',
      'Model',
      'Color',
      'Weight',
      'Dimensions',
      'Warranty',

      // Display
      'Screen Size',
      'Resolution',
      'Display Type',
      'Refresh Rate',
      'Touch Screen',

      // Processor / Performance
      'Processor',
      'CPU Cores',
      'GPU',
      'RAM',
      'Storage',
      'Expandable Storage',

      // Battery
      'Battery Capacity',
      'Battery Type',
      'Charging Type',
      'Fast Charging',
      'Wireless Charging',

      // Camera
      'Rear Camera',
      'Front Camera',
      'Camera Features',
      'Video Recording',
      'Flash',

      // OS / Software
      'Operating System',
      'OS Version',
      'User Interface',
      'Pre-installed Apps',

      // Connectivity
      'Wi-Fi',
      'Bluetooth',
      'NFC',
      'GPS',
      'USB Type',
      'Network Type',

      // Sensors
      'Fingerprint Sensor',
      'Face Recognition',
      'Accelerometer',
      'Gyroscope',
      'Proximity Sensor',
      'Ambient Light Sensor',

      // Audio / Media
      'Speaker',
      'Headphone Jack',
      'Audio Features',
      'FM Radio',

      // Others
      'Water Resistance',
      'Dust Resistance',
      'Certification',
      'Price',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dropdown Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _nameController,
                  title: 'Product Name',
                  label: 'Enter Product Name',
                  keyboardType: TextInputType.text,
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
                  controller: _descriptionController,
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

                /// 🔹 First Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                          BlocBuilder<
                            DropdownBloc<BrandModel>,
                            DropdownState<BrandModel>
                          >(
                            builder: (context, state) {
                              final bloc = context
                                  .read<DropdownBloc<BrandModel>>();
                              return CustomDropdown<BrandModel>(
                                needExpanded: true,
                                title: 'Brand',
                                bloc: bloc,
                                hintText: 'Select Brand',
                                itemToString: (b) => b.name,
                                // img: (b) => b.logoUrl!,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a brand';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child:
                          BlocBuilder<
                            DropdownBloc<CategoryModel>,
                            DropdownState<CategoryModel>
                          >(
                            builder: (context, state) {
                              final bloc = context
                                  .read<DropdownBloc<CategoryModel>>();
                              return CustomDropdown<CategoryModel>(
                                needExpanded: true,
                                title: 'Category',
                                bloc: bloc,
                                hintText: 'Select Category',
                                itemToString: (c) => c.name,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a category';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                    ),
                  ],
                ),

                /// 🔹 Second Row
                Row(
                  children: [
                    Expanded(
                      child:
                          BlocBuilder<
                            DropdownBloc<AvailabilityModel>,
                            DropdownState<AvailabilityModel>
                          >(
                            builder: (context, state) {
                              final bloc = context
                                  .read<DropdownBloc<AvailabilityModel>>();
                              return CustomDropdown<AvailabilityModel>(
                                needExpanded: true,
                                title: 'Availability',
                                bloc: bloc,
                                hintText: 'Select Availability',
                                itemToString: (a) => a.status,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select availability';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                    ),

                    const SizedBox(width: 8),
                    Expanded(
                      child:
                          BlocBuilder<
                            DropdownBloc<Map<String, dynamic>>,
                            DropdownState<Map<String, dynamic>>
                          >(
                            builder: (context, state) {
                              final bloc = context
                                  .read<DropdownBloc<Map<String, dynamic>>>();
                              return CustomDropdown<Map<String, dynamic>>(
                                needExpanded: true,
                                title: 'Delivery Timescale',
                                bloc: bloc,
                                hintText: 'Select Delivery Timescale',
                                // isExpanable: true,
                                itemToString: (c) => c['label'].toString(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select a timescale';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                BlocBuilder<
                  DropdownBloc<CommonModel>,
                  DropdownState<CommonModel>
                >(
                  builder: (context, state) {
                    final bloc = context.read<DropdownBloc<CommonModel>>();
                    return CustomDropdown<CommonModel>(
                      needExpanded: true,
                      title: 'Specific Type',
                      bloc: bloc,
                      hintText: 'Select Specific Type',
                      // isExpanable: true,
                      itemToString: (c) => c.name,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a Specific Type';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),

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
                    if (_formKey.currentState!.validate()) {
                      final brand =
                          (context.read<DropdownBloc<BrandModel>>().state
                                  as DropdownLoaded<BrandModel>?)
                              ?.selectedItem;
                      final category =
                          (context.read<DropdownBloc<CategoryModel>>().state
                                  as DropdownLoaded<CategoryModel>?)
                              ?.selectedItem;
                      final availability =
                          (context.read<DropdownBloc<AvailabilityModel>>().state
                                  as DropdownLoaded<AvailabilityModel>?)
                              ?.selectedItem;
                      final timescale =
                          (context
                                      .read<
                                        DropdownBloc<Map<String, dynamic>>
                                      >()
                                      .state
                                  as DropdownLoaded<Map<String, dynamic>>?)
                              ?.selectedItem;

                      log('Brand: ${brand?.name}');
                      log('Category: ${category?.name}');
                      log('Availability: ${availability?.status}');
                      log("Timescale: ${timescale?['label']}");

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
