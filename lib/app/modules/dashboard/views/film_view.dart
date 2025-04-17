import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FilmView extends GetView {
  const FilmView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FilmView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FilmView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
