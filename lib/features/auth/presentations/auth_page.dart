import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ecommerce_app/app/core/storage/secure_storage.dart';
import 'package:ecommerce_app/app/di/injector.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // SecureStorage().saveAccessToken('abcadaldlald');
          // print('abc');
          final res = await sl<Dio>().get('/product');

          // if (res.statusCode == 200) {
          //   log(res.data.toString());
          // }
        },
      ),
    );
  }
}
