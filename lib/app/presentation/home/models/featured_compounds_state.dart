import 'package:pubchem/app/domain/models/compound.dart';

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