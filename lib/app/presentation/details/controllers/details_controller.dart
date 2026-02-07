import 'package:pubchem/app/presentation/details/models/details_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pubchem/app/core/provider/providers.dart';

part 'details_controller.g.dart';

@riverpod
class DetailsController extends _$DetailsController {
  bool _isDisposed = false;

  @override
  DetailsState build(int cid) {
    _isDisposed = false;

    // Properly schedule side effect after build completes
    ref.onDispose(() {
      _isDisposed = true;
    });

    ref.listenSelf((previous, next) {
      // Initial load happens here
    });

    // Schedule initial load using WidgetsBinding (proper way to defer side effects)
    Future(() => _loadDetails(cid));

    return const DetailsState(isLoading: true);
  }

  Future<void> _loadDetails(int cid) async {
    if (_isDisposed) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final details =
          await ref.read(getCompoundDetailsUseCaseProvider).call(cid);

      // Only update state if not disposed
      if (!_isDisposed) {
        state = state.copyWith(
          isLoading: false,
          details: details,
          errorMessage: null,
        );
      }
    } catch (error) {
      // Only update state if not disposed
      if (!_isDisposed) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        );
      }
    }
  }

  Future<void> retry(int cid) async {
    await _loadDetails(cid);
  }
}