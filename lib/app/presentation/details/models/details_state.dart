import 'package:pubchem/app/domain/models/compound_details.dart';

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