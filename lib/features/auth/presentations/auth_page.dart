import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/di/injector.dart';
import 'package:ecommerce_app/features/product/data/datasource/dropdown_data_source.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Column(
        children: [
          const BrandDropdown(),
          // FutureBuilder(
          //   future: DropdownRemoteDataSource(dio: sl()).fetchBrands(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       // Loading state
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError) {
          //       // Error state
          //       return Center(child: Text('Error: ${snapshot.error}'));
          //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //       // Empty data state
          //       return const Center(child: Text('No brands found'));
          //     } else {
          //       // Success state, display list of brands
          //       final brands = snapshot.data;
          //       return ListView.builder(
          //         itemCount: brands!.length,
          //         itemBuilder: (context, index) {
          //           final brand = brands[index];
          //           return ListTile(
          //             title: Text(
          //               brand.name,
          //             ),
          //             trailing: brand.logoUrl != null
          //                 ? Image.network(
          //                     brand.logoUrl,
          //                     width: 100,
          //                     height: 50,
          //                     fit: BoxFit.contain,
          //                   )
          //                 : const Icon(Icons.image_not_supported),
          //           );
          //         },
          //       );
          //     }
          //   },
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await  SecureStorage().saveAccessToken('abcadaldlald');
          // await  SecureStorage().clear();

          // print('abc');
          // final res = await sl<Dio>().get('/product');

          // if (res.statusCode == 200) {
          //   log(res.data.toString());
          // }
        },
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> getBrand() async {
  try {
    final res = await sl<Dio>().get('/brand/');

    if (res.statusCode == 200) {
      // Ensure data exists and is a List
      final data = res.data['data'];
      if (data is List) {
        return data.cast<Map<String, dynamic>>();
      }
    }
    // Return empty list if status code != 200 or data is invalid
    return [];
  } catch (e) {
    // Optionally log the error
    print('Error fetching brand: $e');
    return [];
  }
}


class BrandDropdown extends StatefulWidget {
  const BrandDropdown({super.key});

  @override
  State<BrandDropdown> createState() => _BrandDropdownState();
}

class _BrandDropdownState extends State<BrandDropdown> {
  String? _selectedBrand;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DropdownRemoteDataSource(dio: sl()).fetchBrands(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No brands found'));
        } else {
          final brands = snapshot.data!;
          return DropdownButtonFormField<String>(
            value: _selectedBrand,
            hint: const Text('Select a brand'),
            items: brands.map((brand) {
              return DropdownMenuItem<String>(
                value: brand.id.toString(), // Assuming each brand has a unique ID
                child: Row(
                  children: [
                    if (brand.logoUrl != null)
                      Image.network(
                        brand.logoUrl!,
                        width: 50,
                        height: 30,
                        fit: BoxFit.contain,
                      )
                    else
                      const Icon(Icons.image_not_supported),
                    const SizedBox(width: 10),
                    Text(brand.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedBrand = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          );
        }
      },
    );
  }
}
