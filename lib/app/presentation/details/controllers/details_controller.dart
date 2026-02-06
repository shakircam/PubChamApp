import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pubchem/app/core/provider/providers.dart';
import 'package:pubchem/app/domain/models/compound_details.dart';

part 'details_controller.g.dart';

class DetailsState {
  final CompoundDetails? details;
  final bool isLoading;
  final String? errorMessage;

  const DetailsState({
    this.details,
    this.isLoading = false,
    this.errorMessage,
  });

  DetailsState copyWith({
    CompoundDetails? details,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DetailsState(
      details: details ?? this.details,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
class DetailsController extends _$DetailsController {
  @override
  DetailsState build(int cid) {
    // Load details after the state is initialized
    Future.microtask(() => _loadDetails(cid));
    return const DetailsState(isLoading: true);
  }

  Future<void> _loadDetails(int cid) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final details =
          await ref.read(getCompoundDetailsUseCaseProvider).call(cid);
      state = state.copyWith(
        isLoading: false,
        details: details,
        errorMessage: null,
      );
    } catch (error, stackTrace) {
      print('Details page error: $error');
      print('Details page Stack trace: $stackTrace');
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> retry(int cid) async {
    await _loadDetails(cid);
  }
}