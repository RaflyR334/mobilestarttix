import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.black,
        body: Scrollbar(
          thumbVisibility: true,
          thickness: 6,
          radius: Radius.circular(8),
          child: Navigator(
            key: Get.nestedKey(1),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (_) => controller.pages[controller.selectedIndex.value],
                settings: settings,
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.changeIndex(index);
            Get.nestedKey(1)!.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (_) => controller.pages[index],
              ),
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter),
              label: 'Film',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Genre',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Akun',
            ),
          ],
        ),
      ),
    );
  }
}
