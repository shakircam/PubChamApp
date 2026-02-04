import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

// Simple state class for Home feature
class HomeState {
  final bool isInitialized;

  const HomeState({
    this.isInitialized = false,
  });

  HomeState copyWith({
    bool? isInitialized,
  }) {
    return HomeState(
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    return const HomeState();
  }

  void initialize() {
    state = state.copyWith(isInitialized: true);
  }
}
