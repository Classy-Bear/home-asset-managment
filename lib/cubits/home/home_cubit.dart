import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository})
      : super(const HomeState(homes: [], fetchStatus: FetchStatus.initial));

  Home getHome(int id) {
    return state.homes.firstWhere((home) => home.id == id);
  }

  Future<void> loadHomes() async {
    emit(state.copyWith(fetchStatus: FetchStatus.loading));
    try {
      if (state.homes.isEmpty) {
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

  Future<void> unchooseHome() async {
    emit(state.copyWith(
      selectedHome: null,
      fetchStatus: FetchStatus.loaded,
    ));
  }

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
