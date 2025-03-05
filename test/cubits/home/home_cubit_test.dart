import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:home_asset_managment/domain/repositories/home_repository.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/domain/models/asset/asset.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

class FakeHome extends Fake implements Home {}

class FakeAsset extends Fake implements Asset {}

void main() {
  late MockHomeRepository mockHomeRepository;
  late HomeCubit homeCubit;

  setUpAll(() {
    registerFallbackValue(FakeHome());
    registerFallbackValue(FakeAsset());
  });

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homeCubit = HomeCubit(homeRepository: mockHomeRepository);
  });

  tearDown(() {
    homeCubit.close();
  });

  // Test data setup
  final mockHomes = [
    const Home(
      id: 1,
      name: 'Home 1',
      address: Address(
        street: '123 Test St',
        city: 'Test City',
        state: 'TS',
        zipCode: '12345',
      ),
      assets: [],
    ),
    const Home(
      id: 2,
      name: 'Home 2',
      address: Address(
        street: '456 Sample Ave',
        city: 'Sample City',
        state: 'SS',
        zipCode: '67890',
      ),
      assets: [],
    ),
  ];

  const mockAsset = Asset(
    id: 1,
    name: 'Test Asset',
    description: 'Test Description',
    category: 'Electronics',
    manufacturer: 'Test Manufacturer',
    modelNumber: 'TM-1000',
    serialNumber: '12345-ABCDE',
  );

  const updatedHome = Home(
    id: 1,
    name: 'Updated Home',
    address: Address(
      street: '123 Updated St',
      city: 'Updated City',
      state: 'US',
      zipCode: '54321',
    ),
    assets: [],
  );

  group('HomeCubit', () {
    group('Initial State', () {
      test('types are correct', () {
        expect(homeCubit.state, isA<HomeState>());
        expect(homeCubit.state.homes, isA<List<Home>>());
        expect(homeCubit.state.fetchStatus, isA<FetchStatus>());
        expect(homeCubit.state.selectedHome, isA<int?>());
        expect(homeCubit.state.error, isA<Error?>());
        expect(homeCubit.state.stackTrace, isA<StackTrace?>());
      });

      test('values are correct', () {
        expect(homeCubit.state.homes, isEmpty);
        expect(homeCubit.state.fetchStatus, equals(FetchStatus.initial));
        expect(homeCubit.state.selectedHome, isNull);
        expect(homeCubit.state.error, isNull);
        expect(homeCubit.state.stackTrace, isNull);
      });
    });

    group('loadHomes', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, loaded] when loadHomes is called successfully',
        build: () {
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => mockHomes);
          return homeCubit;
        },
        act: (cubit) => cubit.loadHomes(),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          HomeState(homes: mockHomes, fetchStatus: FetchStatus.loaded),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.getHomes()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, error] when loadHomes throws an exception',
        build: () {
          when(() => mockHomeRepository.getHomes()).thenThrow(Error());
          return homeCubit;
        },
        act: (cubit) => cubit.loadHomes(),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) {
              return state.fetchStatus == FetchStatus.error &&
                  state.error != null;
            },
          ),
        ],
      );

      blocTest<HomeCubit, HomeState>(
        'does not call repository.getHomes when homes are not empty',
        build: () {
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => mockHomes);
          return homeCubit;
        },
        seed: () => HomeState(
          homes: mockHomes,
          fetchStatus: FetchStatus.loaded,
        ),
        act: (cubit) => cubit.loadHomes(),
        expect: () => [],
        verify: (cubit) {
          verifyNever(() => mockHomeRepository.getHomes());
        },
      );
    });

    group('chooseHome', () {
      blocTest<HomeCubit, HomeState>(
        'emits correct state when chooseHome is called',
        build: () => homeCubit,
        act: (cubit) => cubit.chooseHome(1),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          const HomeState(
            homes: [],
            fetchStatus: FetchStatus.loaded,
            selectedHome: 1,
          ),
        ],
      );
    });

    group('unchooseHome', () {
      blocTest<HomeCubit, HomeState>(
        'sets selectedHome to null',
        build: () => homeCubit,
        seed: () => HomeState(
          homes: mockHomes,
          fetchStatus: FetchStatus.loaded,
          selectedHome: 1,
        ),
        act: (cubit) => cubit.unchooseHome(),
        expect: () => [
          HomeState(
            homes: mockHomes,
            fetchStatus: FetchStatus.loaded,
            selectedHome: null,
          ),
        ],
      );
    });

    group('getHome', () {
      blocTest<HomeCubit, HomeState>(
        'returns correct home by id',
        seed: () => HomeState(
          homes: mockHomes,
          fetchStatus: FetchStatus.loaded,
        ),
        build: () => homeCubit,
        act: (cubit) => cubit.getHome(1),
        expect: () => [],
        verify: (cubit) {
          expect(cubit.getHome(1), equals(mockHomes[0]));
          expect(cubit.getHome(2), equals(mockHomes[1]));
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits error state when home with given id does not exist',
        seed: () => HomeState(
          homes: mockHomes,
          fetchStatus: FetchStatus.loaded,
        ),
        build: () => homeCubit,
        act: (cubit) => cubit.getHome(999),
        expect: () => [],
        verify: (cubit) {
          expect(cubit.getHome(999), isNull);
        },
      );
    });

    group('addHome', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, loaded] with updated homes when addHome is called successfully',
        build: () {
          when(() => mockHomeRepository.addHome(any()))
              .thenAnswer((_) async => mockHomes[0]);
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => mockHomes);
          return homeCubit;
        },
        act: (cubit) => cubit.addHome(mockHomes[0]),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          HomeState(homes: mockHomes, fetchStatus: FetchStatus.loaded),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.addHome(any())).called(1);
          verify(() => mockHomeRepository.getHomes()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, error] when addHome throws an exception',
        build: () {
          when(() => mockHomeRepository.addHome(any())).thenThrow(Error());
          return homeCubit;
        },
        act: (cubit) => cubit.addHome(mockHomes[0]),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) {
              return state.fetchStatus.isError && state.error != null;
            },
          ),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.addHome(any())).called(1);
        },
      );
    });

    group('updateHome', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, loaded] with updated homes when updateHome is called successfully',
        build: () {
          when(() => mockHomeRepository.updateHome(any()))
              .thenAnswer((_) async => updatedHome);
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => [updatedHome, mockHomes[1]]);
          return homeCubit;
        },
        act: (cubit) => cubit.updateHome(updatedHome),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          HomeState(
            homes: [updatedHome, mockHomes[1]],
            fetchStatus: FetchStatus.loaded,
          ),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.updateHome(any())).called(1);
          verify(() => mockHomeRepository.getHomes()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, error] when updateHome throws an exception',
        build: () {
          when(() => mockHomeRepository.updateHome(any())).thenThrow(Error());
          return homeCubit;
        },
        act: (cubit) => cubit.updateHome(updatedHome),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) {
              return state.fetchStatus.isError && state.error != null;
            },
          ),
        ],
      );
    });

    group('deleteHome', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, loaded] with updated homes when deleteHome is called successfully',
        build: () {
          when(() => mockHomeRepository.deleteHome(any()))
              .thenAnswer((_) async {});
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => [mockHomes[1]]);
          return homeCubit;
        },
        act: (cubit) => cubit.deleteHome(1),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          HomeState(homes: [mockHomes[1]], fetchStatus: FetchStatus.loaded),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.deleteHome(1)).called(1);
          verify(() => mockHomeRepository.getHomes()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, error] when deleteHome throws an exception',
        build: () {
          when(() => mockHomeRepository.deleteHome(any())).thenThrow(Error());
          return homeCubit;
        },
        act: (cubit) => cubit.deleteHome(1),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) {
              return state.fetchStatus.isError && state.error != null;
            },
          ),
        ],
      );
    });

    group('addAssetToHome', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, loaded] with updated homes when addAssetToHome is called successfully',
        build: () {
          when(() => mockHomeRepository.addAssetToHome(any(), any()))
              .thenAnswer((_) async {});
          const homeWithAsset = Home(
            id: 1,
            name: 'Home 1',
            address: Address(
              street: '123 Test St',
              city: 'Test City',
              state: 'TS',
              zipCode: '12345',
            ),
            assets: [mockAsset],
          );
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => [homeWithAsset, mockHomes[1]]);
          return homeCubit;
        },
        act: (cubit) => cubit.addAssetToHome(1, mockAsset),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) =>
                state.fetchStatus == FetchStatus.loaded &&
                state.homes.length == 2 &&
                state.homes[0].assets.length == 1,
          ),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.addAssetToHome(any(), any()))
              .called(1);
          verify(() => mockHomeRepository.getHomes()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, error] when addAssetToHome throws an exception',
        build: () {
          when(() => mockHomeRepository.addAssetToHome(any(), any()))
              .thenThrow(Error());
          return homeCubit;
        },
        act: (cubit) => cubit.addAssetToHome(1, mockAsset),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) =>
                state.fetchStatus == FetchStatus.error && state.error != null,
          ),
        ],
      );
    });

    group('removeAssetFromHome', () {
      blocTest<HomeCubit, HomeState>(
        'emits [loading, loaded] with updated homes when removeAssetFromHome is called successfully',
        build: () {
          when(() => mockHomeRepository.removeAssetFromHome(any(), any()))
              .thenAnswer((_) async {});
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => mockHomes);
          return homeCubit;
        },
        act: (cubit) => cubit.removeAssetFromHome(1, 1),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          HomeState(homes: mockHomes, fetchStatus: FetchStatus.loaded),
        ],
        verify: (_) {
          verify(() => mockHomeRepository.removeAssetFromHome(any(), any()))
              .called(1);
          verify(() => mockHomeRepository.getHomes()).called(1);
        },
      );

      blocTest<HomeCubit, HomeState>(
        'emits [loading, error] when removeAssetFromHome throws an exception',
        build: () {
          when(() => mockHomeRepository.removeAssetFromHome(any(), any()))
              .thenThrow(Error());
          return homeCubit;
        },
        act: (cubit) => cubit.removeAssetFromHome(1, 1),
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          predicate<HomeState>(
            (state) =>
                state.fetchStatus == FetchStatus.error && state.error != null,
          ),
        ],
      );
    });

    group('Integration Tests', () {
      blocTest<HomeCubit, HomeState>(
        'emits correct states when performing a sequence of operations',
        build: () {
          when(() => mockHomeRepository.getHomes())
              .thenAnswer((_) async => mockHomes);
          return homeCubit;
        },
        act: (cubit) async {
          await cubit.loadHomes();
          await cubit.chooseHome(1);
          await cubit.unchooseHome();
        },
        expect: () => [
          const HomeState(homes: [], fetchStatus: FetchStatus.loading),
          HomeState(homes: mockHomes, fetchStatus: FetchStatus.loaded),
          HomeState(homes: mockHomes, fetchStatus: FetchStatus.loading),
          HomeState(
            homes: mockHomes,
            fetchStatus: FetchStatus.loaded,
            selectedHome: 1,
          ),
          HomeState(
            homes: mockHomes,
            fetchStatus: FetchStatus.loaded,
            selectedHome: null,
          ),
        ],
      );
    });

    group('FetchStatusX', () {
      test('extensions work correctly', () {
        expect(FetchStatus.initial.isInitial, isTrue);
        expect(FetchStatus.loading.isLoading, isTrue);
        expect(FetchStatus.loaded.isLoaded, isTrue);
        expect(FetchStatus.error.isError, isTrue);

        expect(FetchStatus.initial.isLoading, isFalse);
        expect(FetchStatus.loading.isLoaded, isFalse);
        expect(FetchStatus.loaded.isError, isFalse);
        expect(FetchStatus.error.isInitial, isFalse);
      });
    });
  });
}
