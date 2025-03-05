import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';
import 'package:home_asset_managment/modules/screens/home_list_screen.dart';
import 'dart:async';

class MockHomeCubit extends Mock implements HomeCubit {
  final StreamController<HomeState> _streamController =
      StreamController<HomeState>.broadcast();
  HomeState _state = const HomeState(
    homes: [],
    fetchStatus: FetchStatus.initial,
  );

  @override
  HomeState get state => _state;

  @override
  Stream<HomeState> get stream => _streamController.stream;

  @override
  void emit(HomeState state) {
    _state = state;
    _streamController.add(state);
  }

  @override
  Future<void> close() async {
    await _streamController.close();
    return Future.value();
  }
}

// Mock GoRouter
class MockGoRouter extends Mock implements GoRouter {}

// Set up the wrapper to provide mocked dependencies
Widget createHomeListScreen(HomeCubit homeCubit) {
  return MaterialApp(
    home: BlocProvider<HomeCubit>.value(
      value: homeCubit,
      child: const HomeListScreen(),
    ),
  );
}

void main() {
  late MockHomeCubit mockHomeCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });

  tearDown(() {
    mockHomeCubit.close();
  });

  group('HomeListScreen', () {
    testWidgets('displays loading indicator when status is loading',
        (tester) async {
      mockHomeCubit.emit(
        const HomeState(
          homes: [],
          fetchStatus: FetchStatus.loading,
        ),
      );

      await tester.pumpWidget(createHomeListScreen(mockHomeCubit));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('My Homes'),
          findsOneWidget); // AppBar title should be visible
    });

    testWidgets('displays empty message when homes list is empty',
        (tester) async {
      mockHomeCubit.emit(
        const HomeState(
          homes: [],
          fetchStatus: FetchStatus.loaded,
        ),
      );

      await tester.pumpWidget(createHomeListScreen(mockHomeCubit));

      expect(find.text('No homes yet. Add your first home!'), findsOneWidget);
    });

    // Test populated homes list
    testWidgets('displays list of homes when data is loaded',
        (tester) async {
      final mockHomes = [
        const Home(
          id: 1,
          name: 'Test Home 1',
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
          name: 'Test Home 2',
          address: Address(
            street: '456 Sample Ave',
            city: 'Sample City',
            state: 'SS',
            zipCode: '67890',
          ),
          assets: [],
        ),
      ];

      mockHomeCubit.emit(
        HomeState(
          homes: mockHomes,
          fetchStatus: FetchStatus.loaded,
        ),
      );

      await tester.pumpWidget(createHomeListScreen(mockHomeCubit));

      // Verify home titles are displayed
      expect(find.text('Test Home 1'), findsOneWidget);
      expect(find.text('Test Home 2'), findsOneWidget);

      // Verify address information
      expect(find.text('123 Test St, Test City, TS 12345'), findsOneWidget);
      expect(
          find.text('456 Sample Ave, Sample City, SS 67890'), findsOneWidget);

      // Verify assets count is displayed
      expect(find.text('0 assets'), findsNWidgets(2));
    });

    // Test error state
    testWidgets('displays error message when there is an error',
        (tester) async {
      final error = Error();
      mockHomeCubit.emit(
        HomeState(
          homes: const [],
          fetchStatus: FetchStatus.error,
          error: error,
        ),
      );

      await tester.pumpWidget(createHomeListScreen(mockHomeCubit));

      expect(find.text('Error: $error'), findsOneWidget);
    });

    testWidgets('displays initial state with load button', (tester) async {
      mockHomeCubit.emit(
        const HomeState(
          homes: [],
          fetchStatus: FetchStatus.initial,
        ),
      );

      when(() => mockHomeCubit.loadHomes()).thenAnswer((_) async {});

      await tester.pumpWidget(createHomeListScreen(mockHomeCubit));

      expect(find.text('Initial state'), findsOneWidget);
      expect(find.text('Load Homes'), findsOneWidget);

      // Test the button click
      await tester.tap(find.text('Load Homes'));
      await tester.pump();

      // Verify loadHomes was called
      verify(() => mockHomeCubit.loadHomes()).called(1);
    });
  });
}
