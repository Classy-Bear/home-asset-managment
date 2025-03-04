import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../domain/models/home/home.dart';
import '../home/home_cubit.dart';
import 'home_form_inputs.dart';
import 'home_form_state.dart';

class HomeFormCubit extends Cubit<HomeFormState> {
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

  bool _validateForm({
    required NameInput name,
    required StreetInput street,
    required CityInput city,
    required StateInput state,
    required ZipCodeInput zipCode,
  }) {
    return Formz.validate([name, street, city, state, zipCode]);
  }

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
