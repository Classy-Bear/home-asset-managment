import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:formz/formz.dart';
import '../../domain/models/home/home.dart';
import 'home_form_inputs.dart';

part 'home_form_state.freezed.dart';

/// Status of the home form submission process.
enum HomeFormStatus {
  /// Form is in its initial state, not yet submitted.
  initial,

  /// Form is currently being submitted.
  submitting,

  /// Form was submitted successfully.
  success,

  /// Form submission failed.
  failure
}

/// State for the home creation/editing form.
///
/// Contains all input fields and validation states for the home form.
@freezed
class HomeFormState with _$HomeFormState {
  const HomeFormState._();

  const factory HomeFormState({
    /// Name input field with validation.
    @Default(NameInput.pure()) NameInput name,

    /// Street address input field with validation.
    @Default(StreetInput.pure()) StreetInput street,

    /// City input field with validation.
    @Default(CityInput.pure()) CityInput city,

    /// State input field with validation.
    @Default(StateInput.pure()) StateInput state,

    /// ZIP code input field with validation.
    @Default(ZipCodeInput.pure()) ZipCodeInput zipCode,

    /// Current submission status of the form from Formz.
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus formStatus,

    /// Higher-level status of the form operation.
    @Default(HomeFormStatus.initial) HomeFormStatus status,

    /// Whether all form fields are valid.
    @Default(false) bool isValid,

    /// Error message if form submission failed.
    String? errorMessage,

    /// Initial home data for edit mode.
    ///
    /// If this is null, the form is in create mode.
    Home? initialHome,
  }) = _HomeFormState;

  /// Whether the form is in edit mode.
  bool get isEditing => initialHome != null;

  /// Gets the address from the form inputs.
  Address get address => Address(
        street: street.value,
        city: city.value,
        state: state.value.toUpperCase(),
        zipCode: zipCode.value,
      );
}
