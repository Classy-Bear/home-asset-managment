import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/domain/repositories/home_repository.dart';
import 'package:collection/collection.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'home_state.dart';

/// A cubit for managing the state of the home.
///
/// This cubit manages the state of the home, including the list of homes,
/// the selected home, and the fetch status.
class HomeCubit extends HydratedCubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository})
      : super(const HomeState(homes: [], fetchStatus: FetchStatus.initial));

  /// Gets the home with the given ID.
  ///
  /// Returns the home if found, otherwise returns null.
  Home? getHome(int id) {
    return state.homes.firstWhereOrNull((home) => home.id == id);
  }

  /// Converts the state to a JSON object.
  ///
  /// Returns the JSON object.
  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      final homes = (json['homes'] as List)
          .map((homeJson) => Home.fromJson(homeJson as Map<String, dynamic>))
          .toList();
      final selectedHome = json['selectedHome'] as int?;
      final fetchStatus = FetchStatus.values[json['fetchStatus'] as int];
      return HomeState(
        homes: homes,
        selectedHome: selectedHome,
        fetchStatus: fetchStatus,
      );
    } catch (_) {
      return null;
    }
  }

  /// Converts the state to a JSON object.
  ///
  /// Returns the JSON object.
  @override
  Map<String, dynamic> toJson(HomeState state) {
    return {
      'homes': state.homes.map((home) => home.toJson()).toList(),
      'selectedHome': state.selectedHome,
      'fetchStatus': state.fetchStatus.index,
    };
  }

  /// Loads the homes.
  ///
  /// This method loads the homes and updates the state.
  Future<void> loadHomes() async {
    try {
      if (state.homes.isEmpty) {
        emit(state.copyWith(fetchStatus: FetchStatus.loading));
        final homes = await homeRepository.getHomes();
        emit(state.copyWith(homes: homes, fetchStatus: FetchStatus.loaded));
      }
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Chooses the home with the given ID.
  ///
  /// This method chooses the home with the given ID and updates the state.
  Future<void> chooseHome(int id) async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      emit(state.copyWith(
        selectedHome: id,
        fetchStatus: FetchStatus.loaded,
      ));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Unchooses the home.
  ///
  /// This method unchooses the home and updates the state.
  Future<void> unchooseHome() async {
    emit(state.copyWith(
      fetchStatus: FetchStatus.loaded,
    ));
  }

  /// Adds a home.
  ///
  /// This method adds a home and updates the state.
  Future<void> addHome(Home home) async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      await homeRepository.addHome(home);
      final homes = await homeRepository.getHomes();
      emit(state.copyWith(
        homes: homes,
        fetchStatus: FetchStatus.loaded,
      ));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Updates a home.
  ///
  /// This method updates a home and updates the state.
  Future<void> updateHome(Home home) async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      await homeRepository.updateHome(home);
      final homes = await homeRepository.getHomes();
      emit(state.copyWith(homes: homes, fetchStatus: FetchStatus.loaded));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Deletes a home.
  ///
  /// This method deletes a home and updates the state.
  Future<void> deleteHome(int id) async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      await homeRepository.deleteHome(id);
      final homes = await homeRepository.getHomes();
      emit(state.copyWith(homes: homes, fetchStatus: FetchStatus.loaded));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Adds an asset to a home.
  ///
  /// This method adds an asset to a home and updates the state.
  Future<void> addAssetToHome(int homeId, Asset asset) async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      await homeRepository.addAssetToHome(homeId, asset);
      final homes = await homeRepository.getHomes();
      emit(state.copyWith(homes: homes, fetchStatus: FetchStatus.loaded));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }

  /// Removes an asset from a home.
  ///
  /// This method removes an asset from a home and updates the state.
  Future<void> removeAssetFromHome(int homeId, int assetId) async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      await homeRepository.removeAssetFromHome(homeId, assetId);
      final homes = await homeRepository.getHomes();
      emit(state.copyWith(homes: homes, fetchStatus: FetchStatus.loaded));
    } catch (e, stackTrace) {
      emit(state.copyWith(
        fetchStatus: FetchStatus.error,
        error: e as Error,
        stackTrace: stackTrace,
      ));
    }
  }
}
