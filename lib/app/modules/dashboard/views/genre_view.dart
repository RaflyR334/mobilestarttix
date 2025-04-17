import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujikom/app/modules/dashboard/controllers/dashboard_controller.dart';

class GenreView extends StatelessWidget {
  final DashboardController controller = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingGenre.value) {
        return Center(child: CircularProgressIndicator());
      } else if (controller.errorMessageGenre.isNotEmpty) {
        return Center(child: Text(controller.errorMessageGenre.value));
      } else if (controller.daftarGenre.isEmpty) {
        return Center(child: Text('Genre tidak ditemukan.'));
      } else {
        return ListView.builder(
          itemCount: controller.daftarGenre.length,
          itemBuilder: (context, index) {
            final genre = controller.daftarGenre[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(genre.namaGenre ?? ''),
              ),
            );
          },
        );
      }
    });
  }
}
