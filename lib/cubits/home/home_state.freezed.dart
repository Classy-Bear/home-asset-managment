// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  /// List of all homes available in the application.
  List<Home> get homes => throw _privateConstructorUsedError;

  /// Current status of the data fetching operation.
  FetchStatus get fetchStatus => throw _privateConstructorUsedError;

  /// ID of the currently selected home, if any.
  int? get selectedHome => throw _privateConstructorUsedError;

  /// Error that occurred during a data operation, if any.
  Error? get error => throw _privateConstructorUsedError;

  /// Stack trace associated with the error, if any.
  StackTrace? get stackTrace => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call(
      {List<Home> homes,
      FetchStatus fetchStatus,
      int? selectedHome,
      Error? error,
      StackTrace? stackTrace});
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homes = null,
    Object? fetchStatus = null,
    Object? selectedHome = freezed,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_value.copyWith(
      homes: null == homes
          ? _value.homes
          : homes // ignore: cast_nullable_to_non_nullable
              as List<Home>,
      fetchStatus: null == fetchStatus
          ? _value.fetchStatus
          : fetchStatus // ignore: cast_nullable_to_non_nullable
              as FetchStatus,
      selectedHome: freezed == selectedHome
          ? _value.selectedHome
          : selectedHome // ignore: cast_nullable_to_non_nullable
              as int?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
          _$HomeStateImpl value, $Res Function(_$HomeStateImpl) then) =
      __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Home> homes,
      FetchStatus fetchStatus,
      int? selectedHome,
      Error? error,
      StackTrace? stackTrace});
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
      _$HomeStateImpl _value, $Res Function(_$HomeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homes = null,
    Object? fetchStatus = null,
    Object? selectedHome = freezed,
    Object? error = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$HomeStateImpl(
      homes: null == homes
          ? _value._homes
          : homes // ignore: cast_nullable_to_non_nullable
              as List<Home>,
      fetchStatus: null == fetchStatus
          ? _value.fetchStatus
          : fetchStatus // ignore: cast_nullable_to_non_nullable
              as FetchStatus,
      selectedHome: freezed == selectedHome
          ? _value.selectedHome
          : selectedHome // ignore: cast_nullable_to_non_nullable
              as int?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Error?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl(
      {final List<Home> homes = const [],
      this.fetchStatus = FetchStatus.initial,
      this.selectedHome,
      this.error,
      this.stackTrace})
      : _homes = homes;

  /// List of all homes available in the application.
  final List<Home> _homes;

  /// List of all homes available in the application.
  @override
  @JsonKey()
  List<Home> get homes {
    if (_homes is EqualUnmodifiableListView) return _homes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_homes);
  }

  /// Current status of the data fetching operation.
  @override
  @JsonKey()
  final FetchStatus fetchStatus;

  /// ID of the currently selected home, if any.
  @override
  final int? selectedHome;

  /// Error that occurred during a data operation, if any.
  @override
  final Error? error;

  /// Stack trace associated with the error, if any.
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'HomeState(homes: $homes, fetchStatus: $fetchStatus, selectedHome: $selectedHome, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality().equals(other._homes, _homes) &&
            (identical(other.fetchStatus, fetchStatus) ||
                other.fetchStatus == fetchStatus) &&
            (identical(other.selectedHome, selectedHome) ||
                other.selectedHome == selectedHome) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_homes),
      fetchStatus,
      selectedHome,
      error,
      stackTrace);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState(
      {final List<Home> homes,
      final FetchStatus fetchStatus,
      final int? selectedHome,
      final Error? error,
      final StackTrace? stackTrace}) = _$HomeStateImpl;

  /// List of all homes available in the application.
  @override
  List<Home> get homes;

  /// Current status of the data fetching operation.
  @override
  FetchStatus get fetchStatus;

  /// ID of the currently selected home, if any.
  @override
  int? get selectedHome;

  /// Error that occurred during a data operation, if any.
  @override
  Error? get error;

  /// Stack trace associated with the error, if any.
  @override
  StackTrace? get stackTrace;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
