import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FilmDetailView extends GetView {
  const FilmDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilmDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FilmDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
