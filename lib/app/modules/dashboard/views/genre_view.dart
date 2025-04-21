import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ujikom/app/modules/dashboard/controllers/genre_controller.dart';

class GenreView extends StatelessWidget {
  final GenreController controller = Get.put(GenreController());

  @override
  Widget build(BuildContext context) {
    // Ambil data genre hanya saat pertama kali widget dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.daftarGenre.isEmpty) {
        controller.ambilGenre();
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Genre Populer",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: TextStyle(color: Colors.redAccent),
            ),
          );
        }

        final data = controller.daftarGenre;

        if (data.isEmpty && controller.isLoading.isTrue) {
          // Shimmer effect saat loading
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: 6, // Tampilkan 6 item shimmer sementara
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[700]!,
                highlightColor: Colors.grey[600]!,
                child: Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 20,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: 100,
                              height: 15,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (data.isEmpty) {
          return Center(
            child: Text(
              "Belum ada genre tersedia.",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final genre = data[index];
            final iconList = [
              Icons.movie,
              Icons.music_note,
              Icons.sports_esports,
              Icons.book,
              Icons.tv,
              Icons.theater_comedy,
            ];
            final genreIcon = iconList[index % iconList.length];

            return FadeInUp(
              duration: Duration(milliseconds: 500 + (index * 100)),
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(genreIcon, color: Colors.white70, size: 32),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            genre.namaGenre ?? '-',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Slug: ${genre.slug}',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
