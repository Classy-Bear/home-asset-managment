import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../domain/models/home/home.dart';
import '../home/home_cubit.dart';
import 'home_form_inputs.dart';
import 'home_form_state.dart';

/// A cubit that manages the state of the home form.
///
/// This cubit manages the state of the home form, including the form inputs and validation.
/// It also manages the submission of the form and the reset of the form.
class HomeFormCubit extends Cubit<HomeFormState> {
  /// The home cubit.
  final HomeCubit homeCubit;

  HomeFormCubit({required this.homeCubit, Home? initialHome})
      : super(HomeFormState(
          initialHome: initialHome,
          name: initialHome != null
              ? NameInput.dirty(initialHome.name)
              : const NameInput.pure(),
          street: initialHome != null
              ? StreetInput.dirty(initialHome.address.street)
              : const StreetInput.pure(),
          city: initialHome != null
              ? CityInput.dirty(initialHome.address.city)
              : const CityInput.pure(),
          state: initialHome != null
              ? StateInput.dirty(initialHome.address.state)
              : const StateInput.pure(),
          zipCode: initialHome != null
              ? ZipCodeInput.dirty(initialHome.address.zipCode)
              : const ZipCodeInput.pure(),
        )) {
    if (initialHome != null) {
      validateForm();
    }
  }

  /// Called when the name input changes.
  ///
  /// This method updates the name input and validates the form.
  void nameChanged(String value) {
    final name = NameInput.dirty(value);
    emit(state.copyWith(
      name: name,
      isValid: _validateForm(
        name: name,
        street: state.street,
        city: state.city,
        state: state.state,
        zipCode: state.zipCode,
      ),
    ));
  }

  /// Called when the street input changes.
  ///
  /// This method updates the street input and validates the form.
  void streetChanged(String value) {
    final street = StreetInput.dirty(value);
    emit(state.copyWith(
      street: street,
      isValid: _validateForm(
        name: state.name,
        street: street,
        city: state.city,
        state: state.state,
        zipCode: state.zipCode,
      ),
    ));
  }

  /// Called when the city input changes.
  ///
  /// This method updates the city input and validates the form.
  void cityChanged(String value) {
    final city = CityInput.dirty(value);
    emit(state.copyWith(
      city: city,
      isValid: _validateForm(
        name: state.name,
        street: state.street,
        city: city,
        state: state.state,
        zipCode: state.zipCode,
      ),
    ));
  }

  /// Called when the state input changes.
  ///
  /// This method updates the state input and validates the form.
  void stateChanged(String value) {
    final stateInput = StateInput.dirty(value);
    emit(state.copyWith(
      state: stateInput,
      isValid: _validateForm(
        name: state.name,
        street: state.street,
        city: state.city,
        state: stateInput,
        zipCode: state.zipCode,
      ),
    ));
  }

  /// Called when the zip code input changes.
  ///
  /// This method updates the zip code input and validates the form.
  void zipCodeChanged(String value) {
    final zipCode = ZipCodeInput.dirty(value);
    emit(state.copyWith(
      zipCode: zipCode,
      isValid: _validateForm(
        name: state.name,
        street: state.street,
        city: state.city,
        state: state.state,
        zipCode: zipCode,
      ),
    ));
  }

  /// Called when the form is validated.
  ///
  /// This method validates the form and updates the state.
  void validateForm() {
    emit(state.copyWith(
      isValid: _validateForm(
        name: state.name,
        street: state.street,
        city: state.city,
        state: state.state,
        zipCode: state.zipCode,
      ),
    ));
  }

  /// Validates the form.
  ///
  /// This method validates the form and returns a boolean value.
  bool _validateForm({
    required NameInput name,
    required StreetInput street,
    required CityInput city,
    required StateInput state,
    required ZipCodeInput zipCode,
  }) {
    return Formz.validate([name, street, city, state, zipCode]);
  }

  /// Resets the form.
  ///
  /// This method resets the form to its initial state.
  void resetForm() {
    emit(const HomeFormState());
  }

  /// Submits the form.
  ///
  /// This method submits the form and updates the home.
  Future<void> submitForm() async {
    if (!state.isValid) return;

    emit(state.copyWith(
      formStatus: FormzSubmissionStatus.inProgress,
      status: HomeFormStatus.submitting,
    ));

    try {
      final address = Address(
        street: state.street.value.trim(),
        city: state.city.value.trim(),
        state: state.state.value.trim().toUpperCase(),
        zipCode: state.zipCode.value.trim(),
      );
      if (state.isEditing) {
        final updatedHome = state.initialHome!.copyWith(
          name: state.name.value.trim(),
          address: address,
        );
        await homeCubit.updateHome(updatedHome);
      } else {
        final newHome = Home(
          id: 0, // Repository will generate an ID
          name: state.name.value.trim(),
          address: address,
        );
        await homeCubit.addHome(newHome);
      }
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.success,
        status: HomeFormStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        formStatus: FormzSubmissionStatus.failure,
        status: HomeFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
