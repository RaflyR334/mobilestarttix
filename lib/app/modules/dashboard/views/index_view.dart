import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexView extends GetView {
  const IndexView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> filmList = [
      {
        "title": "The Batman",
        "image": "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg"
      },
      {
        "title": "Avengers: Endgame",
        "image": "https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg"
      },
      {
        "title": "Spider-Man: No Way Home",
        "image": "https://image.tmdb.org/t/p/w500/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg"
      },
    ];

    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header App
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Icon(Icons.movie_filter_outlined, size: 30, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text(
                    "MovieTime",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Stylish Slider Film
            SizedBox(
              height: 260,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.75),
                itemCount: filmList.length,
                itemBuilder: (context, index) {
                  final film = filmList[index];
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(film['image']!),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                                Colors.black.withOpacity(0.5),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                        // Text film
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Text(
                            film['title']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Katalog Film",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 10),

            // Modern List Film
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filmList.length,
                itemBuilder: (context, index) {
                  final film = filmList[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: Image.network(
                            film['image']!,
                            width: 100,
                            height: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  film['title']!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Film aksi populer 2022",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(Icons.chevron_right_rounded,
                            size: 28, color: Colors.white54),
                        SizedBox(width: 12),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
