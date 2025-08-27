import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../env.dart';
import '../viewmodel/home_view_model.dart';
import '../../domain/entity/movie.dart';
import 'detail_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (map) {
            final now = map['now'] ?? <Movie>[];
            final popular = map['popular'] ?? <Movie>[];
            final top = map['top'] ?? <Movie>[];
            final upcoming = map['upcoming'] ?? <Movie>[];

            final topPopular = popular.isNotEmpty ? popular.first : null;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child:
                            (topPopular != null &&
                                topPopular.posterPath.isNotEmpty)
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailPage(
                                        movieId: topPopular.id,
                                        heroTag: 'popular_top_${topPopular.id}',
                                        posterPath: topPopular.posterPath,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'popular_top_${topPopular.id}',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      Env.posterUrl(topPopular.posterPath),
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.blueGrey,
                                ),
                              ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // 섹션 리스트
                  _buildMovieSection(
                    context: context,
                    title: "현재 상영중",
                    items: now,
                    showRanking: false,
                  ),
                  _buildMovieSection(
                    context: context,
                    title: "인기순",
                    items: popular.take(20).toList(),
                    showRanking: true, // 랭킹 숫자 표시
                    wideGap: true, // 인기순 간격 넓게
                  ),
                  _buildMovieSection(
                    context: context,
                    title: "평점 높은순",
                    items: top,
                  ),
                  _buildMovieSection(
                    context: context,
                    title: "개봉예정",
                    items: upcoming,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // 공통 섹션 위젯
  Widget _buildMovieSection({
    required BuildContext context,
    required String title,
    required List<Movie> items,
    bool showRanking = false,
    bool wideGap = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length.clamp(0, 20),
            itemBuilder: (context, index) {
              final movie = items[index];
              final poster = movie.posterPath;
              final heroTag = '$title-${movie.id}-$index'; // 같은 위젯 내 중복 방지

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        movieId: movie.id,
                        heroTag: heroTag,
                        posterPath: movie.posterPath,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: wideGap ? 24 : 8, // 인기순만 간격 넓게
                  ),
                  width: 130,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomLeft,
                    children: [
                      Hero(
                        tag: heroTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: poster.isEmpty
                              ? Container(color: Colors.grey)
                              : Image.network(
                                  Env.posterUrl(poster, width: 185),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      if (showRanking)
                        Positioned(
                          // 순위 위치 조정
                          left: -30,
                          bottom: -20,
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
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
