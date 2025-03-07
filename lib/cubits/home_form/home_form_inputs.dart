import 'package:formz/formz.dart';

/// Possible validation errors for the home name field.
enum NameValidationError {
  /// The name is empty.
  empty
}

/// Input validation for the home name field.
///
/// Uses [Formz] to validate that the name is not empty.
class NameInput extends FormzInput<String, NameValidationError> {
  /// Creates a pristine name input with empty default value.
  const NameInput.pure() : super.pure('');

  /// Creates a dirty name input with the given value.
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    return value.trim().isEmpty ? NameValidationError.empty : null;
  }
}

/// Possible validation errors for the street field.
enum StreetValidationError {
  /// The street is empty.
  empty
}

/// Input validation for the street address field.
///
/// Uses [Formz] to validate that the street is not empty.
class StreetInput extends FormzInput<String, StreetValidationError> {
  /// Creates a pristine street input with empty default value.
  const StreetInput.pure() : super.pure('');

  /// Creates a dirty street input with the given value.
  const StreetInput.dirty([super.value = '']) : super.dirty();

  @override
  StreetValidationError? validator(String value) {
    return value.trim().isEmpty ? StreetValidationError.empty : null;
  }
}

/// Possible validation errors for the city field.
enum CityValidationError {
  /// The city is empty.
  empty
}

/// Input validation for the city field.
///
/// Uses [Formz] to validate that the city is not empty.
class CityInput extends FormzInput<String, CityValidationError> {
  /// Creates a pristine city input with empty default value.
  const CityInput.pure() : super.pure('');

  /// Creates a dirty city input with the given value.
  const CityInput.dirty([super.value = '']) : super.dirty();

  @override
  CityValidationError? validator(String value) {
    return value.trim().isEmpty ? CityValidationError.empty : null;
  }
}

/// Possible validation errors for the state field.
enum StateValidationError {
  /// The state is empty.
  empty,
  /// The state is not a valid US state.
  invalid
}

/// Input validation for the state field.
///
/// Uses [Formz] to validate that the state is not empty.
class StateInput extends FormzInput<String, StateValidationError> {
  /// Creates a pristine state input with empty default value.
  const StateInput.pure() : super.pure('');

  /// Creates a dirty state input with the given value.
  const StateInput.dirty([super.value = '']) : super.dirty();

  @override
  StateValidationError? validator(String value) {
    if (value.trim().isEmpty) return StateValidationError.empty;
    if (value.trim().length != 2) return StateValidationError.invalid;
    return null;
  }
}

/// Possible validation errors for the ZIP code field.
enum ZipCodeValidationError {
  /// The ZIP code is empty.
  empty,

  /// The ZIP code format is invalid.
  invalid
}

/// Input validation for the ZIP code field.
///
/// Uses [Formz] to validate that the ZIP code is not empty and
/// follows the US ZIP code format (5 digits or 5+4 format).
class ZipCodeInput extends FormzInput<String, ZipCodeValidationError> {
  /// Creates a pristine ZIP code input with empty default value.
  const ZipCodeInput.pure() : super.pure('');

  /// Creates a dirty ZIP code input with the given value.
  const ZipCodeInput.dirty([super.value = '']) : super.dirty();

  static final _zipRegex = RegExp(r'^\d{5}(-\d{4})?$');

  @override
  ZipCodeValidationError? validator(String value) {
    if (value.trim().isEmpty) return ZipCodeValidationError.empty;
    if (!_zipRegex.hasMatch(value.trim())) {
      return ZipCodeValidationError.invalid;
    }
    return null;
  }
}
