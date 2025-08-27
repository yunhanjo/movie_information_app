import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../../domain/entity/movie_detail.dart';

class DetailViewModel extends StateNotifier<AsyncValue<MovieDetail?>> {
  final Ref ref; // Reader -> Ref
  final int movieId;

  DetailViewModel(this.ref, this.movieId) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      final detail = await ref.read(detailUsecaseProvider)(
        movieId,
      ); // ref.read(...)
      state = AsyncValue.data(detail);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// 메모리 자동 해제: autoDispose.family 권장
final detailViewModelProvider = StateNotifierProvider.autoDispose
    .family<DetailViewModel, AsyncValue<MovieDetail?>, int>(
      (ref, id) => DetailViewModel(ref, id),
    );
