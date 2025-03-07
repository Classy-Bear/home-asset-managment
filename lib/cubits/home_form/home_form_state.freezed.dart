// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeFormState {
  /// Name input field with validation.
  NameInput get name => throw _privateConstructorUsedError;

  /// Street address input field with validation.
  StreetInput get street => throw _privateConstructorUsedError;

  /// City input field with validation.
  CityInput get city => throw _privateConstructorUsedError;

  /// State input field with validation.
  StateInput get state => throw _privateConstructorUsedError;

  /// ZIP code input field with validation.
  ZipCodeInput get zipCode => throw _privateConstructorUsedError;

  /// Current submission status of the form from Formz.
  FormzSubmissionStatus get formStatus => throw _privateConstructorUsedError;

  /// Higher-level status of the form operation.
  HomeFormStatus get status => throw _privateConstructorUsedError;

  /// Whether all form fields are valid.
  bool get isValid => throw _privateConstructorUsedError;

  /// Error message if form submission failed.
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Initial home data for edit mode.
  ///
  /// If this is null, the form is in create mode.
  Home? get initialHome => throw _privateConstructorUsedError;

  /// Create a copy of HomeFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeFormStateCopyWith<HomeFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeFormStateCopyWith<$Res> {
  factory $HomeFormStateCopyWith(
          HomeFormState value, $Res Function(HomeFormState) then) =
      _$HomeFormStateCopyWithImpl<$Res, HomeFormState>;
  @useResult
  $Res call(
      {NameInput name,
      StreetInput street,
      CityInput city,
      StateInput state,
      ZipCodeInput zipCode,
      FormzSubmissionStatus formStatus,
      HomeFormStatus status,
      bool isValid,
      String? errorMessage,
      Home? initialHome});

  $HomeCopyWith<$Res>? get initialHome;
}

/// @nodoc
class _$HomeFormStateCopyWithImpl<$Res, $Val extends HomeFormState>
    implements $HomeFormStateCopyWith<$Res> {
  _$HomeFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? formStatus = null,
    Object? status = null,
    Object? isValid = null,
    Object? errorMessage = freezed,
    Object? initialHome = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameInput,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as StreetInput,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityInput,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as StateInput,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as ZipCodeInput,
      formStatus: null == formStatus
          ? _value.formStatus
          : formStatus // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomeFormStatus,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      initialHome: freezed == initialHome
          ? _value.initialHome
          : initialHome // ignore: cast_nullable_to_non_nullable
              as Home?,
    ) as $Val);
  }

  /// Create a copy of HomeFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeCopyWith<$Res>? get initialHome {
    if (_value.initialHome == null) {
      return null;
    }

    return $HomeCopyWith<$Res>(_value.initialHome!, (value) {
      return _then(_value.copyWith(initialHome: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeFormStateImplCopyWith<$Res>
    implements $HomeFormStateCopyWith<$Res> {
  factory _$$HomeFormStateImplCopyWith(
          _$HomeFormStateImpl value, $Res Function(_$HomeFormStateImpl) then) =
      __$$HomeFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NameInput name,
      StreetInput street,
      CityInput city,
      StateInput state,
      ZipCodeInput zipCode,
      FormzSubmissionStatus formStatus,
      HomeFormStatus status,
      bool isValid,
      String? errorMessage,
      Home? initialHome});

  @override
  $HomeCopyWith<$Res>? get initialHome;
}

/// @nodoc
class __$$HomeFormStateImplCopyWithImpl<$Res>
    extends _$HomeFormStateCopyWithImpl<$Res, _$HomeFormStateImpl>
    implements _$$HomeFormStateImplCopyWith<$Res> {
  __$$HomeFormStateImplCopyWithImpl(
      _$HomeFormStateImpl _value, $Res Function(_$HomeFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? street = null,
    Object? city = null,
    Object? state = null,
    Object? zipCode = null,
    Object? formStatus = null,
    Object? status = null,
    Object? isValid = null,
    Object? errorMessage = freezed,
    Object? initialHome = freezed,
  }) {
    return _then(_$HomeFormStateImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as NameInput,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as StreetInput,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as CityInput,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as StateInput,
      zipCode: null == zipCode
          ? _value.zipCode
          : zipCode // ignore: cast_nullable_to_non_nullable
              as ZipCodeInput,
      formStatus: null == formStatus
          ? _value.formStatus
          : formStatus // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as HomeFormStatus,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      initialHome: freezed == initialHome
          ? _value.initialHome
          : initialHome // ignore: cast_nullable_to_non_nullable
              as Home?,
    ));
  }
}

/// @nodoc

class _$HomeFormStateImpl extends _HomeFormState {
  const _$HomeFormStateImpl(
      {this.name = const NameInput.pure(),
      this.street = const StreetInput.pure(),
      this.city = const CityInput.pure(),
      this.state = const StateInput.pure(),
      this.zipCode = const ZipCodeInput.pure(),
      this.formStatus = FormzSubmissionStatus.initial,
      this.status = HomeFormStatus.initial,
      this.isValid = false,
      this.errorMessage,
      this.initialHome})
      : super._();

  /// Name input field with validation.
  @override
  @JsonKey()
  final NameInput name;

  /// Street address input field with validation.
  @override
  @JsonKey()
  final StreetInput street;

  /// City input field with validation.
  @override
  @JsonKey()
  final CityInput city;

  /// State input field with validation.
  @override
  @JsonKey()
  final StateInput state;

  /// ZIP code input field with validation.
  @override
  @JsonKey()
  final ZipCodeInput zipCode;

  /// Current submission status of the form from Formz.
  @override
  @JsonKey()
  final FormzSubmissionStatus formStatus;

  /// Higher-level status of the form operation.
  @override
  @JsonKey()
  final HomeFormStatus status;

  /// Whether all form fields are valid.
  @override
  @JsonKey()
  final bool isValid;

  /// Error message if form submission failed.
  @override
  final String? errorMessage;

  /// Initial home data for edit mode.
  ///
  /// If this is null, the form is in create mode.
  @override
  final Home? initialHome;

  @override
  String toString() {
    return 'HomeFormState(name: $name, street: $street, city: $city, state: $state, zipCode: $zipCode, formStatus: $formStatus, status: $status, isValid: $isValid, errorMessage: $errorMessage, initialHome: $initialHome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeFormStateImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.zipCode, zipCode) || other.zipCode == zipCode) &&
            (identical(other.formStatus, formStatus) ||
                other.formStatus == formStatus) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.initialHome, initialHome) ||
                other.initialHome == initialHome));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, street, city, state,
      zipCode, formStatus, status, isValid, errorMessage, initialHome);

  /// Create a copy of HomeFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeFormStateImplCopyWith<_$HomeFormStateImpl> get copyWith =>
      __$$HomeFormStateImplCopyWithImpl<_$HomeFormStateImpl>(this, _$identity);
}

abstract class _HomeFormState extends HomeFormState {
  const factory _HomeFormState(
      {final NameInput name,
      final StreetInput street,
      final CityInput city,
      final StateInput state,
      final ZipCodeInput zipCode,
      final FormzSubmissionStatus formStatus,
      final HomeFormStatus status,
      final bool isValid,
      final String? errorMessage,
      final Home? initialHome}) = _$HomeFormStateImpl;
  const _HomeFormState._() : super._();

  /// Name input field with validation.
  @override
  NameInput get name;

  /// Street address input field with validation.
  @override
  StreetInput get street;

  /// City input field with validation.
  @override
  CityInput get city;

  /// State input field with validation.
  @override
  StateInput get state;

  /// ZIP code input field with validation.
  @override
  ZipCodeInput get zipCode;

  /// Current submission status of the form from Formz.
  @override
  FormzSubmissionStatus get formStatus;

  /// Higher-level status of the form operation.
  @override
  HomeFormStatus get status;

  /// Whether all form fields are valid.
  @override
  bool get isValid;

  /// Error message if form submission failed.
  @override
  String? get errorMessage;

  /// Initial home data for edit mode.
  ///
  /// If this is null, the form is in create mode.
  @override
  Home? get initialHome;

  /// Create a copy of HomeFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeFormStateImplCopyWith<_$HomeFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
