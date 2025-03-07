import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/home/home.dart';

part 'home_state.freezed.dart';

/// Status of data fetching operations.
enum FetchStatus {
  /// Initial state before any fetch operation has started.
  initial,

  /// Fetch operation is in progress.
  loading,

  /// Fetch operation completed successfully.
  loaded,

  /// Fetch operation failed with an error.
  error,
}

/// Extension methods for [FetchStatus] to simplify status checking.
extension FetchStatusX on FetchStatus {
  /// Whether this status is [FetchStatus.initial].
  bool get isInitial => this == FetchStatus.initial;

  /// Whether this status is [FetchStatus.loading].
  bool get isLoading => this == FetchStatus.loading;

  /// Whether this status is [FetchStatus.loaded].
  bool get isLoaded => this == FetchStatus.loaded;

  /// Whether this status is [FetchStatus.error].
  bool get isError => this == FetchStatus.error;
}

/// State for the home listing and management feature.
///
/// Tracks the list of homes, their fetch status, currently selected home,
/// and any errors that occur during data operations.
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    /// List of all homes available in the application.
    @Default([]) List<Home> homes,

    /// Current status of the data fetching operation.
    @Default(FetchStatus.initial) FetchStatus fetchStatus,

    /// ID of the currently selected home, if any.
    int? selectedHome,

    /// Error that occurred during a data operation, if any.
    Error? error,

    /// Stack trace associated with the error, if any.
    StackTrace? stackTrace,
  }) = _HomeState;
}
