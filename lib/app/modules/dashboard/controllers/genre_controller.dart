import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ujikom/app/data/genre_response.dart';
import 'dart:convert';

import 'package:ujikom/app/utils/api.dart';

class GenreController extends GetxController {
  var daftarGenre = <Genre>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> ambilGenre() async {
    isLoading.value = true;
    errorMessage.value = '';
    final token = GetStorage().read('access_token');

    try {
      final response = await http.get(
        Uri.parse(BaseUrl.genre),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': "application/json",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final genreResponse = GenreResponse.fromJson(jsonResponse);

        if (genreResponse.success == true) {
          daftarGenre.assignAll(genreResponse.data ?? []);
        } else {
          errorMessage.value =
              genreResponse.message ?? 'Gagal mengambil data genre';
        }
      } else {
        errorMessage.value =
            'Terjadi kesalahan: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
