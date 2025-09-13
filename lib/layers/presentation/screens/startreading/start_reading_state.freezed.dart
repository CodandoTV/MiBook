// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'start_reading_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StartReadingState {

 String? get inputErrorMessage; double get progress; bool get shouldNavigateBack;
/// Create a copy of StartReadingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartReadingStateCopyWith<StartReadingState> get copyWith => _$StartReadingStateCopyWithImpl<StartReadingState>(this as StartReadingState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartReadingState&&(identical(other.inputErrorMessage, inputErrorMessage) || other.inputErrorMessage == inputErrorMessage)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.shouldNavigateBack, shouldNavigateBack) || other.shouldNavigateBack == shouldNavigateBack));
}


@override
int get hashCode => Object.hash(runtimeType,inputErrorMessage,progress,shouldNavigateBack);

@override
String toString() {
  return 'StartReadingState(inputErrorMessage: $inputErrorMessage, progress: $progress, shouldNavigateBack: $shouldNavigateBack)';
}


}

/// @nodoc
abstract mixin class $StartReadingStateCopyWith<$Res>  {
  factory $StartReadingStateCopyWith(StartReadingState value, $Res Function(StartReadingState) _then) = _$StartReadingStateCopyWithImpl;
@useResult
$Res call({
 String? inputErrorMessage, double progress, bool shouldNavigateBack
});




}
/// @nodoc
class _$StartReadingStateCopyWithImpl<$Res>
    implements $StartReadingStateCopyWith<$Res> {
  _$StartReadingStateCopyWithImpl(this._self, this._then);

  final StartReadingState _self;
  final $Res Function(StartReadingState) _then;

/// Create a copy of StartReadingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inputErrorMessage = freezed,Object? progress = null,Object? shouldNavigateBack = null,}) {
  return _then(StartReadingState(
inputErrorMessage: freezed == inputErrorMessage ? _self.inputErrorMessage : inputErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,shouldNavigateBack: null == shouldNavigateBack ? _self.shouldNavigateBack : shouldNavigateBack // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StartReadingState].
extension StartReadingStatePatterns on StartReadingState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
