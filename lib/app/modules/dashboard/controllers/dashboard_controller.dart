import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ujikom/app/data/genre_response.dart';
import 'dart:convert';

import 'package:ujikom/app/modules/dashboard/views/film_view.dart';
import 'package:ujikom/app/modules/dashboard/views/genre_view.dart';
import 'package:ujikom/app/modules/dashboard/views/index_view.dart';
import 'package:ujikom/app/modules/dashboard/views/profile_view.dart';
import 'package:ujikom/app/utils/api.dart';


class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    IndexView(),
    FilmView(),
    GenreView(),
    ProfileView(),
  ];

  //GENRE CONTROLLER

  var daftarGenre = <Data>[].obs;
  var isLoadingGenre = false.obs;
  var errorMessageGenre = ''.obs;

  Future<void> fetchGenre() async {
    isLoadingGenre.value = true;
    errorMessageGenre.value = '';

    try {
      var response = await http.get(
        Uri.parse(BaseUrl.genre));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var genreResponse = GenreResponse.fromJson(jsonData);
        if (genreResponse.success == true && genreResponse.data != null) {
          daftarGenre.assignAll(genreResponse.data!);
        } else {
          errorMessageGenre.value = genreResponse.message ?? 'Gagal memuat data.';
        }
      } else {
        errorMessageGenre.value = 'Gagal memuat data. Code: ${response.statusCode}';
      }
    } catch (e) {
      errorMessageGenre.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoadingGenre.value = false;
    }
  }
  // END GENRE CONTROLLER

  @override
  void onInit() {
    super.onInit();
    fetchGenre();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
