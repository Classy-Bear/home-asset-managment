import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:formz/formz.dart';
import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home/home_state.dart';
import 'package:home_asset_managment/cubits/home_form/home_form_cubit.dart';
import 'package:home_asset_managment/cubits/home_form/home_form_state.dart';
import 'package:home_asset_managment/cubits/home_form/home_form_inputs.dart'
    as inputs;
import 'package:home_asset_managment/modules/screens/home_form_screen.dart';
import 'dart:async';

// Mock dependencies
class MockHomeCubit extends Mock implements HomeCubit {
  final StreamController<HomeState> _streamController =
      StreamController<HomeState>.broadcast();

  @override
  Stream<HomeState> get stream => _streamController.stream;

  @override
  Future<void> close() async {
    await _streamController.close();
    return Future.value();
  }
}

class MockHomeFormCubit extends Mock implements HomeFormCubit {
  final StreamController<HomeFormState> _streamController =
      StreamController<HomeFormState>.broadcast();
  HomeFormState _state = const HomeFormState(
    name: inputs.NameInput.pure(),
    street: inputs.StreetInput.pure(),
    city: inputs.CityInput.pure(),
    state: inputs.StateInput.pure(),
    zipCode: inputs.ZipCodeInput.pure(),
    status: HomeFormStatus.initial,
    formStatus: FormzSubmissionStatus.initial,
    isValid: false,
  );

  @override
  HomeFormState get state => _state;

  @override
  Stream<HomeFormState> get stream => _streamController.stream;

  @override
  void emit(HomeFormState state) {
    _state = state;
    _streamController.add(state);
  }

  @override
  Future<void> close() async {
    await _streamController.close();
    return Future.value();
  }
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockHomeCubit mockHomeCubit;
  late MockHomeFormCubit mockHomeFormCubit;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    mockHomeFormCubit = MockHomeFormCubit();
    mockNavigatorObserver = MockNavigatorObserver();

    // Set up the default behavior for the mock
    mockHomeFormCubit.emit(
      const HomeFormState(
        name: inputs.NameInput.pure(),
        street: inputs.StreetInput.pure(),
        city: inputs.CityInput.pure(),
        state: inputs.StateInput.pure(),
        zipCode: inputs.ZipCodeInput.pure(),
        status: HomeFormStatus.initial,
        formStatus: FormzSubmissionStatus.initial,
        isValid: false,
      ),
    );
  });

  tearDown(() {
    mockHomeCubit.close();
    mockHomeFormCubit.close();
  });

  // Helper function to build the HomeFormView with mocked dependencies
  Widget createHomeFormScreen() {
    return MaterialApp(
      navigatorObservers: [mockNavigatorObserver],
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>.value(value: mockHomeCubit),
          BlocProvider<HomeFormCubit>.value(value: mockHomeFormCubit),
        ],
        child: const HomeFormView(),
      ),
    );
  }

  group('HomeFormScreen', () {
    testWidgets('renders form fields correctly', (tester) async {
      await tester.pumpWidget(createHomeFormScreen());

      // Verify form fields are rendered
      expect(find.text('Home Name'), findsOneWidget);
      expect(find.text('e.g., Mountain Retreat'), findsOneWidget);

      // Address section should be visible
      expect(find.byType(AddressSection), findsOneWidget);

      // Submit button should be visible
      expect(find.byType(SubmitButton), findsOneWidget);
    });

    testWidgets('calls nameChanged when name input changes', (tester) async {
      when(() => mockHomeFormCubit.nameChanged(any())).thenReturn(null);

      await tester.pumpWidget(createHomeFormScreen());

      // Enter text in the name field
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Home Name'), 'New Test Home');

      // Verify the cubit method was called
      verify(() => mockHomeFormCubit.nameChanged('New Test Home')).called(1);
    });

    testWidgets('displays validation errors when fields are invalid',
        (WidgetTester tester) async {
      // Set up the state with validation errors
      mockHomeFormCubit.emit(
        const HomeFormState(
          name: inputs.NameInput.dirty(''), // Empty name will cause error
          street: inputs.StreetInput.pure(),
          city: inputs.CityInput.pure(),
          state: inputs.StateInput.pure(),
          zipCode: inputs.ZipCodeInput.pure(),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: false,
        ),
      );

      await tester.pumpWidget(createHomeFormScreen());

      // Verify error message is displayed
      expect(find.text('Home name is required'), findsOneWidget);
    });

    testWidgets('navigates back on successful submission', (tester) async {
      // First set normal state
      mockHomeFormCubit.emit(
        const HomeFormState(
          name: inputs.NameInput.dirty('Test Home'),
          street: inputs.StreetInput.dirty('123 Test St'),
          city: inputs.CityInput.dirty('Test City'),
          state: inputs.StateInput.dirty('TS'),
          zipCode: inputs.ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: true,
        ),
      );

      await tester.pumpWidget(createHomeFormScreen());

      // Then change state to success to trigger navigation
      mockHomeFormCubit.emit(
        const HomeFormState(
          name: inputs.NameInput.dirty('Test Home'),
          street: inputs.StreetInput.dirty('123 Test St'),
          city: inputs.CityInput.dirty('Test City'),
          state: inputs.StateInput.dirty('TS'),
          zipCode: inputs.ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.success,
          formStatus: FormzSubmissionStatus.success,
          isValid: true,
        ),
      );

      // Trigger the BlocListener by rebuilding
      await tester.pumpWidget(createHomeFormScreen());
      await tester.pumpAndSettle();

      expect(mockHomeFormCubit.state.status, equals(HomeFormStatus.success));
      expect(mockHomeFormCubit.state.formStatus,
          equals(FormzSubmissionStatus.success));
    });

    testWidgets('shows error snackbar on submission failure',
        (tester) async {
      // First set normal state
      mockHomeFormCubit.emit(
        const HomeFormState(
          name: inputs.NameInput.dirty('Test Home'),
          street: inputs.StreetInput.dirty('123 Test St'),
          city: inputs.CityInput.dirty('Test City'),
          state: inputs.StateInput.dirty('TS'),
          zipCode: inputs.ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: true,
        ),
      );

      await tester.pumpWidget(createHomeFormScreen());

      // Then change state to failure to trigger error message
      mockHomeFormCubit.emit(
        const HomeFormState(
          name: inputs.NameInput.dirty('Test Home'),
          street: inputs.StreetInput.dirty('123 Test St'),
          city: inputs.CityInput.dirty('Test City'),
          state: inputs.StateInput.dirty('TS'),
          zipCode: inputs.ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.failure,
          formStatus: FormzSubmissionStatus.failure,
          isValid: true,
          errorMessage: 'Test error message',
        ),
      );

      // Trigger the BlocListener by rebuilding
      await tester.pumpWidget(createHomeFormScreen());
      await tester.pumpAndSettle();

      // Verify error snackbar
      expect(find.text('Test error message'), findsOneWidget);
    });
  });
}
