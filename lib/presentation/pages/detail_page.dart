import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../env.dart';
import '../viewmodel/detail_view_model.dart';

class DetailPage extends ConsumerWidget {
  final int movieId; // TMDB 상세 호출
  final String heroTag; // Hero 전환
  final String? posterPath; // 포스터 이미지 경로

  const DetailPage({
    super.key,
    required this.movieId,
    required this.heroTag,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailViewModelProvider(movieId));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: (posterPath == null || posterPath!.isEmpty)
                      ? Container(
                          width: double.infinity,
                          color: Colors.blueGrey,
                        )
                      : Image.network(
                          Env.posterUrl(posterPath!),
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                ),
              ),

              state.when(
                loading: () => Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(e.toString()),
                ),
                data: (detail) {
                  final d = detail;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    (d?.title ?? '').isNotEmpty
                                        ? d!.title
                                        : '제목 정보 없음',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (d?.releaseDate != null)
                                  Text(
                                    _dateStr(d!.releaseDate),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            ),

                            SizedBox(height: 4),

                            // 태그라인
                            if ((d?.tagline ?? '').isNotEmpty) Text(d!.tagline),
                            if ((d?.tagline ?? '').isNotEmpty)
                              SizedBox(height: 4),

                            // 러닝타임
                            if ((d?.runtime ?? 0) > 0) Text("${d!.runtime}분"),

                            // 구분선
                            SizedBox(height: 12),
                            Divider(),
                            SizedBox(height: 4),

                            // 장르 칩 (알약 스타일)
                            if ((d?.genres ?? []).isNotEmpty)
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: d!.genres
                                    .map(
                                      (g) => Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey.shade600,
                                            width: 1,
                                          ),
                                        ),
                                        child: Text(
                                          g,
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                            // 구분선
                            SizedBox(height: 4),
                            Divider(),
                            SizedBox(height: 12),

                            // 영화 설명
                            Text(
                              (d?.overview ?? '').isNotEmpty
                                  ? d!.overview
                                  : "설명 정보가 없습니다.",
                            ),
                          ],
                        ),
                      ),

                      // 구분선
                      Divider(),
                      SizedBox(height: 12),

                      // 흥행정보
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "흥행정보",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          children: [
                            _InfoCard(
                              label: "평점",
                              value: _numStr(d?.voteAverage),
                            ),
                            _InfoCard(
                              label: "투표수",
                              value: _numStr(d?.voteCount, digits: 0),
                            ),
                            _InfoCard(
                              label: "인기점수",
                              value: _numStr(d?.popularity),
                            ),
                            _InfoCard(label: "예산", value: _money(d?.budget)),
                            _InfoCard(label: "수익", value: _money(d?.revenue)),
                          ],
                        ),
                      ),

                      SizedBox(height: 8),

                      // 제작사 로고
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (d?.productionCompanyLogos ?? []).length,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (context, index) {
                            final path = d!.productionCompanyLogos[index];
                            final logoUrl = (path.isEmpty)
                                ? ''
                                : Env.posterUrl(path, width: 154);

                            if (logoUrl.isEmpty) {
                              return SizedBox.shrink();
                            }

                            return Container(
                              margin: EdgeInsets.all(8),
                              padding: EdgeInsets.all(8),
                              color: Colors.white.withOpacity(0.9),
                              width: 120,
                              height: 80,
                              child: Image.network(
                                logoUrl,
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _dateStr(DateTime? date) {
    if (date == null) return '';
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }

  static String _numStr(num? v, {int digits = 1}) {
    if (v == null) return "-";
    if (v is int || digits == 0) return "$v";
    return v.toStringAsFixed(digits);
  }

  static String _money(int? v) {
    if (v == null) return "-";
    if (v >= 1000000000) return "\$${(v / 1000000000).toStringAsFixed(1)}B";
    if (v >= 1000000) return "\$${(v / 1000000).toStringAsFixed(1)}M";
    return "\$$v";
  }
}

// 흥행정보 카드
class _InfoCard extends StatelessWidget {
  final String label;
  final String value;
  const _InfoCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
