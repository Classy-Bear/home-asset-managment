import 'package:equatable/equatable.dart';
import '../../domain/models/home/home.dart';

/// State for the home listing and management feature.
///
/// Tracks the list of homes, their fetch status, currently selected home,
/// and any errors that occur during data operations.
class HomeState extends Equatable {
  /// List of all homes available in the application.
  final List<Home> homes;

  /// Current status of the data fetching operation.
  final FetchStatus fetchStatus;

  /// ID of the currently selected home, if any.
  final int? selectedHome;

  /// Error that occurred during a data operation, if any.
  final Error? error;

  /// Stack trace associated with the error, if any.
  final StackTrace? stackTrace;

  const HomeState({
    required this.homes,
    required this.fetchStatus,
    this.selectedHome,
    this.error,
    this.stackTrace,
  });

  @override
  List<Object?> get props =>
      [homes, selectedHome, fetchStatus, error, stackTrace];

  /// Creates a copy of this state with the given fields replaced.
  HomeState copyWith({
    List<Home>? homes,
    int? selectedHome,
    FetchStatus? fetchStatus,
    Error? error,
    StackTrace? stackTrace,
  }) {
    return HomeState(
      homes: homes ?? this.homes,
      selectedHome: selectedHome ?? this.selectedHome,
      fetchStatus: fetchStatus ?? this.fetchStatus,
      error: error ?? this.error,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }
}

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
