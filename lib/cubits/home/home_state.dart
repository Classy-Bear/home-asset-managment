import 'package:equatable/equatable.dart';
import '../../domain/models/home/home.dart';

class HomeState extends Equatable {
  final List<Home> homes;
  final FetchStatus fetchStatus;
  final int? selectedHome;
  final Error? error;
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

enum FetchStatus {
  initial,
  loading,
  loaded,
  error,
}

extension FetchStatusX on FetchStatus {
  bool get isInitial => this == FetchStatus.initial;
  bool get isLoading => this == FetchStatus.loading;
  bool get isLoaded => this == FetchStatus.loaded;
  bool get isError => this == FetchStatus.error;
}
