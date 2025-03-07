import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../domain/models/home/home.dart';
import 'home_form_inputs.dart';

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
class HomeFormState extends Equatable {
  /// Name input field with validation.
  final NameInput name;

  /// Street address input field with validation.
  final StreetInput street;

  /// City input field with validation.
  final CityInput city;

  /// State input field with validation.
  final StateInput state;

  /// ZIP code input field with validation.
  final ZipCodeInput zipCode;

  /// Current submission status of the form from Formz.
  final FormzSubmissionStatus formStatus;

  /// Higher-level status of the form operation.
  final HomeFormStatus status;

  /// Whether all form fields are valid.
  final bool isValid;

  /// Error message if form submission failed.
  final String? errorMessage;

  /// Initial home data for edit mode.
  ///
  /// If this is null, the form is in create mode.
  final Home? initialHome;

  /// Creates a new home form state with the given fields.
  const HomeFormState({
    this.name = const NameInput.pure(),
    this.street = const StreetInput.pure(),
    this.city = const CityInput.pure(),
    this.state = const StateInput.pure(),
    this.zipCode = const ZipCodeInput.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.status = HomeFormStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.initialHome,
  });

  /// Creates a copy of this state with the given fields replaced.
  HomeFormState copyWith({
    NameInput? name,
    StreetInput? street,
    CityInput? city,
    StateInput? state,
    ZipCodeInput? zipCode,
    FormzSubmissionStatus? formStatus,
    HomeFormStatus? status,
    bool? isValid,
    String? errorMessage,
    Home? initialHome,
  }) {
    return HomeFormState(
      name: name ?? this.name,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      formStatus: formStatus ?? this.formStatus,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      initialHome: initialHome ?? this.initialHome,
    );
  }

  @override
  List<Object?> get props => [
        name,
        street,
        city,
        state,
        zipCode,
        formStatus,
        status,
        isValid,
        errorMessage,
        initialHome,
      ];

  /// Whether the form is in edit mode.
  bool get isEditing => initialHome != null;

  Address get address => Address(
        street: street.value,
        city: city.value,
        state: state.value.toUpperCase(),
        zipCode: zipCode.value,
      );
}
