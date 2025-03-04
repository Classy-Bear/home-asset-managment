import 'package:formz/formz.dart';

// Name Input
enum NameValidationError { empty }

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    return value.trim().isEmpty ? NameValidationError.empty : null;
  }
}

// Street Input
enum StreetValidationError { empty }

class StreetInput extends FormzInput<String, StreetValidationError> {
  const StreetInput.pure() : super.pure('');
  const StreetInput.dirty([super.value = '']) : super.dirty();

  @override
  StreetValidationError? validator(String value) {
    return value.trim().isEmpty ? StreetValidationError.empty : null;
  }
}

// City Input
enum CityValidationError { empty }

class CityInput extends FormzInput<String, CityValidationError> {
  const CityInput.pure() : super.pure('');
  const CityInput.dirty([super.value = '']) : super.dirty();

  @override
  CityValidationError? validator(String value) {
    return value.trim().isEmpty ? CityValidationError.empty : null;
  }
}

// State Input
enum StateValidationError { empty, invalid }

class StateInput extends FormzInput<String, StateValidationError> {
  const StateInput.pure() : super.pure('');
  const StateInput.dirty([super.value = '']) : super.dirty();

  @override
  StateValidationError? validator(String value) {
    if (value.trim().isEmpty) return StateValidationError.empty;
    if (value.trim().length != 2) return StateValidationError.invalid;
    return null;
  }
}

// Zip Code Input
enum ZipCodeValidationError { empty, invalid }

class ZipCodeInput extends FormzInput<String, ZipCodeValidationError> {
  const ZipCodeInput.pure() : super.pure('');
  const ZipCodeInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _zipCodeRegExp = RegExp(r'^\d{5}(-\d{4})?$');

  @override
  ZipCodeValidationError? validator(String value) {
    if (value.trim().isEmpty) return ZipCodeValidationError.empty;
    if (!_zipCodeRegExp.hasMatch(value.trim())) {
      return ZipCodeValidationError.invalid;
    }
    return null;
  }
}
