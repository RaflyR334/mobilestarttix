import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ujikom/app/modules/dashboard/views/dashboard_view.dart';
import 'package:ujikom/app/utils/api.dart';

class RegisterController extends GetxController {
  final _getConnect = GetConnect();

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

    final response = await _getConnect.post(BaseUrl.register, {
      'name': nameController.text,
      'email': emailController.text,
      'tanggal_lahir': tanggalLahirController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfirmationController.text,
    });

    if (response.statusCode == 200) {
      authToken.write('acces_token', response.body['acces_token']);
      Get.offAll(() => const DashboardView());
    } else {
      Get.snackbar(
        'Error',
        response.body['error'].toString(),
        icon: const Icon(Icons.error),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        forwardAnimationCurve: Curves.bounceIn,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      );
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
