import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pubchem/app/domain/models/compound.dart';
import 'package:pubchem/app/utils/compound_constants.dart';

part 'featured_compounds_controller.g.dart';

class FeaturedCompoundsState {
  final List<Compound> displayedCompounds;
  final bool isLoading;
  final bool hasMore;
  final int currentPage;

  const FeaturedCompoundsState({
    this.displayedCompounds = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.currentPage = 0,
  });

  FeaturedCompoundsState copyWith({
    List<Compound>? displayedCompounds,
    bool? isLoading,
    bool? hasMore,
    int? currentPage,
  }) {
    return FeaturedCompoundsState(
      displayedCompounds: displayedCompounds ?? this.displayedCompounds,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

@riverpod
class FeaturedCompoundsController extends _$FeaturedCompoundsController {
  static const int _itemsPerPage = 8;
  final List<Compound> _allCompounds = allCompounds;

  @override
  FeaturedCompoundsState build() {
    // Load initial items
    Future.microtask(loadMore);
    return const FeaturedCompoundsState();
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    // Simulate loading delay for better UX (optional)
    await Future.delayed(const Duration(milliseconds: 300));

    final startIndex = state.currentPage * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;

    if (startIndex >= _allCompounds.length) {
      state = state.copyWith(
        hasMore: false,
        isLoading: false,
      );
      return;
    }

    final newItems = _allCompounds.sublist(
      startIndex,
      endIndex > _allCompounds.length ? _allCompounds.length : endIndex,
    );

    state = state.copyWith(
      displayedCompounds: [...state.displayedCompounds, ...newItems],
      currentPage: state.currentPage + 1,
      isLoading: false,
      hasMore: endIndex < _allCompounds.length,
    );
  }
}