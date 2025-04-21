import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import 'package:ujikom/app/data/film_response.dart';
import 'package:ujikom/app/utils/api.dart';

class FilmController extends GetxController {
  var daftarFilm = <Film>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ambilFilm();
  }

  Future<void> ambilFilm() async {
    isLoading.value = true;
    errorMessage.value = '';
    final token = GetStorage().read('access_token');

    try {
      final response = await http.get(
        Uri.parse(BaseUrl.film), // Ganti sesuai endpoint
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final filmResponse = FilmResponse.fromJson(jsonResponse);

        if (filmResponse.success == true) {
          daftarFilm.assignAll(filmResponse.data ?? []);
        } else {
          errorMessage.value =
              filmResponse.message ?? 'Gagal mengambil data film';
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
