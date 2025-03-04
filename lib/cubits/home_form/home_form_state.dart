import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../domain/models/home/home.dart';
import 'home_form_inputs.dart';

enum HomeFormStatus { initial, submitting, success, failure }

class HomeFormState extends Equatable {
  final NameInput name;
  final StreetInput street;
  final CityInput city;
  final StateInput state;
  final ZipCodeInput zipCode;
  final FormzSubmissionStatus formStatus;
  final HomeFormStatus status;
  final bool isValid;
  final String? errorMessage;
  final Home? initialHome;

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

  bool get isEditing => initialHome != null;

  Address get address => Address(
        street: street.value,
        city: city.value,
        state: state.value.toUpperCase(),
        zipCode: zipCode.value,
      );
}
