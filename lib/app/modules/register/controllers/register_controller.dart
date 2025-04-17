import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ujikom/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ujikom/app/utils/api.dart';

class RegisterController extends GetxController {
  // Controller untuk input field
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  final authToken = GetStorage();

  void registerNow() async {
    // Validasi input
    if (!_validasiRegister()) return;

    try {
      final response = await http.post(
        Uri.parse(BaseUrl.register),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'tanggal_lahir': tanggalLahirController.text,
          'password': passwordController.text,
          'password_confirmation': passwordConfirmationController.text,
        }),
      );

      print("📥 Status code: ${response.statusCode}");
      print("📥 Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        authToken.write('access_token', responseData['access_token']);
        print("✅ Token disimpan: ${authToken.read('access_token')}");
        Get.offAll(() => const DashboardView());
      } else {
        final responseData = jsonDecode(response.body);
        Get.snackbar(
          'Error',
          responseData['error'].toString(),
          icon: const Icon(Icons.error),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
        );
        print("❌ Register gagal: ${responseData['error']}");
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

  bool _validasiRegister() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        tanggalLahirController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmationController.text.isEmpty) {
      Get.snackbar("Error", "Semua field wajib diisi!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Format email tidak valid!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    if (passwordController.text.length < 6) {
      Get.snackbar("Error", "Password minimal 6 karakter!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    if (passwordController.text != passwordConfirmationController.text) {
      Get.snackbar("Error", "Konfirmasi password tidak cocok!",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    tanggalLahirController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.onClose();
  }
}
