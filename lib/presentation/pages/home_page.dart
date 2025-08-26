import 'package:flutter/material.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "가장 인기있는",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Hero(
                      tag: 'popular_top',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const DetailPage(heroTag: 'popular_top'),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            color: Colors.blueGrey, // 샘플 색상
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 리스트뷰 섹션
              _buildMovieSection(context, "현재 상영중"),
              _buildMovieSection(context, "인기순", showRanking: true),
              _buildMovieSection(context, "평점 높은순"),
              _buildMovieSection(context, "개봉예정"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieSection(
    BuildContext context,
    String title, {
    bool showRanking = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) {
              final heroTag = '$title-$index';
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(heroTag: heroTag),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: title == "인기순" ? 24 : 8, //인기순 경우 간격 넓어지게
                  ),
                  width: 120,
                  child: Stack(
                    clipBehavior: Clip.none, // 영역 넘어가도 보이게
                    alignment: Alignment.bottomLeft,
                    children: [
                      Hero(
                        tag: heroTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(color: Colors.grey),
                        ),
                      ),
                      if (showRanking)
                        Positioned(
                          left: -30,
                          bottom: -20,
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
