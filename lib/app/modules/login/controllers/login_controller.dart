import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ujikom/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ujikom/app/utils/api.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final authToken = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  void loginNow() async {
    print("🔐 login button ditekan");

    try {
      final response = await http.post(
        Uri.parse(BaseUrl.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      print("📥 Status code: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        authToken.write('access_token', responseData['access_token']);
        print("✅ Token disimpan: ${authToken.read('access_token')}");
        Get.offAll(() => DashboardView());
      } else {
        final responseData = jsonDecode(response.body);
        Get.snackbar(
          'Login Gagal',
          responseData['error'].toString(),
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
        );
        print("❌ Login gagal: ${responseData['error']}");
      }
    } catch (e) {
      Get.snackbar(
        'Terjadi Kesalahan',
        'Tidak bisa terhubung ke server.',
        icon: const Icon(Icons.error_outline),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      print("❌ Exception: $e");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
