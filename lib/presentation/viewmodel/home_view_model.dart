import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers.dart';
import '../../domain/entity/movie.dart';

class HomeViewModel
    extends StateNotifier<AsyncValue<Map<String, List<Movie>>>> {
  final Ref ref;
  HomeViewModel(this.ref) : super(const AsyncValue.loading()) {
    load();
  }

  Future<void> load() async {
    try {
      final now = await ref.read(nowPlayingUsecaseProvider)();
      final pop = await ref.read(popularUsecaseProvider)();
      final top = await ref.read(topRatedUsecaseProvider)();
      final upc = await ref.read(upcomingUsecaseProvider)();

      state = AsyncValue.data({
        'now': now ?? [],
        'popular': pop ?? [],
        'top': top ?? [],
        'upcoming': upc ?? [],
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<Map<String, List<Movie>>>>(
      (ref) => HomeViewModel(ref),
    );
