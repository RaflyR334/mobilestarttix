import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ujikom/app/modules/dashboard/controllers/film_controller.dart';

class FilmView extends StatelessWidget {
  final FilmController controller = Get.put(FilmController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Film Populer"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return ListView.builder(
            itemCount: 6,
            itemBuilder: (_, __) => Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.grey.shade700,
              child: ListTile(
                leading: Container(width: 50, height: 80, color: Colors.white),
                title: Container(height: 16, width: double.infinity, color: Colors.white),
                subtitle: Container(height: 14, width: 150, color: Colors.white),
              ),
            ),
          );
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.white)));
        }

        return ListView.builder(
          itemCount: controller.daftarFilm.length,
          itemBuilder: (context, index) {
            final film = controller.daftarFilm[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  film.poster ?? '',
                  width: 50,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.movie, color: Colors.grey),
                ),
              ),
              title: Text(
                film.judul ?? '-',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${film.genre?.namaGenre ?? 'Tidak ada genre'} • ${film.tahunRilis}",
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onTap: () {
                // navigasi ke detail film (opsional)
              },
            );
          },
        );
      }),
    );
  }
}
