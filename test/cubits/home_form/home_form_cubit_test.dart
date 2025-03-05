import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:home_asset_managment/cubits/home/home_cubit.dart';
import 'package:home_asset_managment/cubits/home_form/home_form_cubit.dart';
import 'package:home_asset_managment/cubits/home_form/home_form_state.dart';
import 'package:home_asset_managment/cubits/home_form/home_form_inputs.dart';
import 'package:home_asset_managment/domain/models/home/home.dart';

class MockHomeCubit extends Mock implements HomeCubit {}

class FakeHome extends Fake implements Home {}

class FakeAddress extends Fake implements Address {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeHome());
    registerFallbackValue(FakeAddress());
  });

  late MockHomeCubit mockHomeCubit;
  late HomeFormCubit homeFormCubit;

  setUp(() {
    mockHomeCubit = MockHomeCubit();
    homeFormCubit = HomeFormCubit(homeCubit: mockHomeCubit);
  });

  tearDown(() {
    homeFormCubit.close();
  });

  group('HomeFormCubit', () {
    group('Initial State', () {
      test('types are correct', () {
        final state = homeFormCubit.state;
        expect(state.name, isA<NameInput>());
        expect(state.street, isA<StreetInput>());
        expect(state.city, isA<CityInput>());
        expect(state.state, isA<StateInput>());
        expect(state.zipCode, isA<ZipCodeInput>());
        expect(state.status, isA<HomeFormStatus>());
        expect(state.formStatus, isA<FormzSubmissionStatus>());
      });

      test('values are correct', () {
        final state = homeFormCubit.state;
        expect(state.name.value, isEmpty);
        expect(state.street.value, isEmpty);
        expect(state.city.value, isEmpty);
        expect(state.state.value, isEmpty);
        expect(state.zipCode.value, isEmpty);
        expect(state.errorMessage, isNull);
      });

      test('is pure', () {
        final state = homeFormCubit.state;
        expect(state.name.isPure, isTrue);
        expect(state.street.isPure, isTrue);
        expect(state.city.isPure, isTrue);
        expect(state.state.isPure, isTrue);
        expect(state.zipCode.isPure, isTrue);
        expect(state.isValid, isFalse);
        expect(state.status, equals(HomeFormStatus.initial));
        expect(state.formStatus, equals(FormzSubmissionStatus.initial));
      });
    });

    group('Field Input Methods', () {
      group('nameChanged', () {
        blocTest<HomeFormCubit, HomeFormState>(
          'emits updated state when nameChanged is called with valid input',
          build: () => homeFormCubit,
          act: (cubit) => cubit.nameChanged('Test Home'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                final name = state.name;
                return name.value == 'Test Home' && name.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when nameChanged is called with empty string',
          build: () => homeFormCubit,
          act: (cubit) => cubit.nameChanged(''),
          expect: () => [
            predicate<HomeFormState>(
                (state) => !state.name.isValid && !state.isValid),
          ],
        );
      });

      group('streetChanged', () {
        blocTest<HomeFormCubit, HomeFormState>(
          'emits updated state when streetChanged is called with valid input',
          build: () => homeFormCubit,
          act: (cubit) => cubit.streetChanged('123 Test St'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                final street = state.street;
                return street.value == '123 Test St' && street.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when streetChanged is called with empty string',
          build: () => homeFormCubit,
          act: (cubit) => cubit.streetChanged(''),
          expect: () => [
            predicate<HomeFormState>(
              (state) => !state.street.isValid && !state.isValid,
            ),
          ],
        );
      });

      group('cityChanged', () {
        blocTest<HomeFormCubit, HomeFormState>(
          'emits updated state when cityChanged is called with valid input',
          build: () => homeFormCubit,
          act: (cubit) => cubit.cityChanged('Test City'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                final city = state.city;
                return city.value == 'Test City' && city.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when cityChanged is called with empty string',
          build: () => homeFormCubit,
          act: (cubit) => cubit.cityChanged(''),
          expect: () => [
            predicate<HomeFormState>(
              (state) => !state.city.isValid && !state.isValid,
            ),
          ],
        );
      });

      group('stateChanged', () {
        blocTest<HomeFormCubit, HomeFormState>(
          'emits updated state when stateChanged is called with valid input',
          build: () => homeFormCubit,
          act: (cubit) => cubit.stateChanged('CA'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                final usState = state.state;
                return usState.value == 'CA' && usState.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when stateChanged is called with empty string',
          build: () => homeFormCubit,
          act: (cubit) => cubit.stateChanged(''),
          expect: () => [
            predicate<HomeFormState>(
              (state) => !state.state.isValid && !state.isValid,
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'handles valid US state abbreviations correctly',
          build: () => homeFormCubit,
          act: (cubit) {
            cubit.stateChanged('CA'); // Valid
            cubit.stateChanged('TX'); // Valid
            cubit.stateChanged('NY'); // Valid
          },
          skip: 2, // Skip the first 2 emissions
          expect: () => [
            predicate<HomeFormState>(
              (state) => state.state.value == 'NY' && state.state.isValid,
            ),
          ],
        );
      });

      group('zipCodeChanged', () {
        blocTest<HomeFormCubit, HomeFormState>(
          'emits updated state when zipCodeChanged is called with valid input',
          build: () => homeFormCubit,
          act: (cubit) => cubit.zipCodeChanged('12345'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                final zipCode = state.zipCode;
                return zipCode.value == '12345' && zipCode.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when zipCodeChanged is called with empty string',
          build: () => homeFormCubit,
          act: (cubit) => cubit.zipCodeChanged(''),
          expect: () => [
            predicate<HomeFormState>(
              (state) => !state.zipCode.isValid && !state.isValid,
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when zipCodeChanged is called with invalid format',
          build: () => homeFormCubit,
          act: (cubit) => cubit.zipCodeChanged('abc'),
          expect: () => [
            predicate<HomeFormState>(
              (state) => !state.zipCode.isValid && !state.isValid,
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when zipCode is too short',
          build: () => homeFormCubit,
          act: (cubit) => cubit.zipCodeChanged('1234'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                return !state.zipCode.isValid && !state.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'emits invalid state when zipCode is too long',
          build: () => homeFormCubit,
          act: (cubit) => cubit.zipCodeChanged('123456'),
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                return !state.zipCode.isValid && !state.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'validates and accepts 5-digit ZIP code',
          build: () => homeFormCubit,
          act: (cubit) {
            cubit.zipCodeChanged('12345');
          },
          expect: () => [
            predicate<HomeFormState>(
              (state) {
                final zipCode = state.zipCode;
                return zipCode.value == '12345' && zipCode.isValid;
              },
            ),
          ],
        );

        blocTest<HomeFormCubit, HomeFormState>(
          'rejects ZIP code with non-numeric characters',
          build: () => homeFormCubit,
          act: (cubit) {
            cubit.zipCodeChanged('1234a');
          },
          expect: () => [
            predicate<HomeFormState>((state) => !state.zipCode.isValid),
          ],
        );
      });
    });

    group('Form Validation', () {
      blocTest<HomeFormCubit, HomeFormState>(
        'validates form when all fields are valid',
        build: () => homeFormCubit,
        act: (cubit) {
          cubit.nameChanged('Test Home');
          cubit.streetChanged('123 Test St');
          cubit.cityChanged('Test City');
          cubit.stateChanged('CA');
          cubit.zipCodeChanged('12345');
        },
        skip: 4, // Skip the first 4 emissions (from the field changes)
        expect: () => [
          predicate<HomeFormState>((state) {
            return state.isValid &&
                state.name.isValid &&
                state.street.isValid &&
                state.city.isValid &&
                state.state.isValid &&
                state.zipCode.isValid;
          }),
        ],
      );

      blocTest<HomeFormCubit, HomeFormState>(
        'maintains form state across multiple field changes',
        build: () => homeFormCubit,
        act: (cubit) {
          cubit.nameChanged('Test Home');
          cubit.streetChanged('123 Test St');
          cubit.cityChanged('Test City');
          cubit.stateChanged('CA');
          cubit.zipCodeChanged('12345');
          // Change a field to invalid state
          cubit.cityChanged('');
          // Change it back to valid
          cubit.cityChanged('Test City Again');
        },
        skip: 6, // Skip all the individual field changes
        expect: () => [
          predicate<HomeFormState>(
            (state) {
              return state.isValid &&
                  state.name.value == 'Test Home' &&
                  state.street.value == '123 Test St' &&
                  state.city.value == 'Test City Again' &&
                  state.state.value == 'CA' &&
                  state.zipCode.value == '12345';
            },
          ),
        ],
      );
    });

    group('Form Submission', () {
      blocTest<HomeFormCubit, HomeFormState>(
        'does not submit when form is invalid',
        build: () => homeFormCubit,
        act: (cubit) => cubit.submitForm(),
        expect: () => [], // Expect no state changes when form is invalid
        verify: (_) {
          verifyNever(() => mockHomeCubit.addHome(any()));
        },
      );

      blocTest<HomeFormCubit, HomeFormState>(
        'submits when form is valid and calls homeCubit.addHome',
        setUp: () {
          when(() => mockHomeCubit.addHome(any())).thenAnswer((_) async {});
        },
        build: () => homeFormCubit,
        seed: () => const HomeFormState(
          name: NameInput.dirty('Test Home'),
          street: StreetInput.dirty('123 Test St'),
          city: CityInput.dirty('Test City'),
          state: StateInput.dirty('CA'),
          zipCode: ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: true,
        ),
        act: (cubit) => cubit.submitForm(),
        expect: () => [
          predicate<HomeFormState>(
            (state) => state.formStatus == FormzSubmissionStatus.inProgress,
          ),
          predicate<HomeFormState>(
            (state) => state.formStatus == FormzSubmissionStatus.success,
          ),
        ],
        verify: (_) {
          verify(() => mockHomeCubit.addHome(any())).called(1);
        },
      );

      blocTest<HomeFormCubit, HomeFormState>(
        'handles error during submission',
        setUp: () {
          when(() => mockHomeCubit.addHome(any()))
              .thenThrow(Exception('Failed to add home'));
        },
        build: () => homeFormCubit,
        seed: () => const HomeFormState(
          name: NameInput.dirty('Test Home'),
          street: StreetInput.dirty('123 Test St'),
          city: CityInput.dirty('Test City'),
          state: StateInput.dirty('CA'),
          zipCode: ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: true,
        ),
        act: (cubit) => cubit.submitForm(),
        expect: () => [
          predicate<HomeFormState>(
            (state) => state.formStatus == FormzSubmissionStatus.inProgress,
          ),
          predicate<HomeFormState>(
            (state) => state.formStatus == FormzSubmissionStatus.failure,
          ),
        ],
      );
    });

    group('Form Reset', () {
      blocTest<HomeFormCubit, HomeFormState>(
        'resets form state when resetForm is called',
        build: () => homeFormCubit,
        seed: () => const HomeFormState(
          name: NameInput.dirty('Test Home'),
          street: StreetInput.dirty('123 Test St'),
          city: CityInput.dirty('Test City'),
          state: StateInput.dirty('CA'),
          zipCode: ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: true,
        ),
        act: (cubit) => cubit.resetForm(),
        expect: () => [
          predicate<HomeFormState>((state) {
            return state.name.isPure &&
                state.street.isPure &&
                state.city.isPure &&
                state.state.isPure &&
                state.zipCode.isPure &&
                state.status == HomeFormStatus.initial &&
                state.formStatus == FormzSubmissionStatus.initial &&
                !state.isValid;
          }),
        ],
      );

      blocTest<HomeFormCubit, HomeFormState>(
        'resets form after successful submission',
        setUp: () {
          when(() => mockHomeCubit.addHome(any())).thenAnswer((_) async {});
        },
        build: () => homeFormCubit,
        seed: () => const HomeFormState(
          name: NameInput.dirty('Test Home'),
          street: StreetInput.dirty('123 Test St'),
          city: CityInput.dirty('Test City'),
          state: StateInput.dirty('CA'),
          zipCode: ZipCodeInput.dirty('12345'),
          status: HomeFormStatus.initial,
          formStatus: FormzSubmissionStatus.initial,
          isValid: true,
        ),
        act: (cubit) async {
          await cubit.submitForm();
          cubit.resetForm();
        },
        expect: () => [
          predicate<HomeFormState>(
            (state) => state.formStatus == FormzSubmissionStatus.inProgress,
          ),
          predicate<HomeFormState>(
            (state) => state.formStatus == FormzSubmissionStatus.success,
          ),
          predicate<HomeFormState>((state) {
            return state.formStatus == FormzSubmissionStatus.initial &&
                state.name.isPure &&
                state.street.isPure &&
                state.city.isPure &&
                state.state.isPure &&
                state.zipCode.isPure;
          }),
        ],
        verify: (_) {
          verify(() => mockHomeCubit.addHome(any())).called(1);
        },
      );
    });

    group('State Transitions', () {
      blocTest<HomeFormCubit, HomeFormState>(
        'handles complex state transitions',
        build: () => homeFormCubit,
        act: (cubit) async {
          cubit.nameChanged('');
          cubit.nameChanged('Test Home');
          cubit.streetChanged('123 Test St');
          cubit.cityChanged('Test City');
          cubit.stateChanged('CA');
          cubit.zipCodeChanged('12345');
          cubit.stateChanged('INVALID');
          cubit.stateChanged('NY');
        },
        expect: () => [
          predicate<HomeFormState>(
            (state) {
              return !state.name.isValid && !state.isValid;
            },
          ),
          predicate<HomeFormState>((state) {
            return state.name.isValid;
          }),
          predicate<HomeFormState>((state) {
            return state.street.isValid;
          }),
          predicate<HomeFormState>((state) {
            return state.city.isValid;
          }),
          predicate<HomeFormState>((state) {
            return state.state.isValid;
          }),
          predicate<HomeFormState>((state) {
            return state.zipCode.isValid && state.isValid;
          }),
          predicate<HomeFormState>((state) {
            return !state.state.isValid && !state.isValid;
          }),
          predicate<HomeFormState>((state) {
            return state.state.isValid && state.isValid;
          }),
        ],
      );
    });
  });
}
