// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookDetailsState {

 bool get isLoading; String? get errorMessage; BookDetailsUI? get bookDetails; double get bookProgress;
/// Create a copy of BookDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookDetailsStateCopyWith<BookDetailsState> get copyWith => _$BookDetailsStateCopyWithImpl<BookDetailsState>(this as BookDetailsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookDetailsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.bookDetails, bookDetails) || other.bookDetails == bookDetails)&&(identical(other.bookProgress, bookProgress) || other.bookProgress == bookProgress));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,errorMessage,bookDetails,bookProgress);

@override
String toString() {
  return 'BookDetailsState(isLoading: $isLoading, errorMessage: $errorMessage, bookDetails: $bookDetails, bookProgress: $bookProgress)';
}


}

/// @nodoc
abstract mixin class $BookDetailsStateCopyWith<$Res>  {
  factory $BookDetailsStateCopyWith(BookDetailsState value, $Res Function(BookDetailsState) _then) = _$BookDetailsStateCopyWithImpl;
@useResult
$Res call({
 String? errorMessage, BookDetailsUI? bookDetails, bool isLoading, double bookProgress
});




}
/// @nodoc
class _$BookDetailsStateCopyWithImpl<$Res>
    implements $BookDetailsStateCopyWith<$Res> {
  _$BookDetailsStateCopyWithImpl(this._self, this._then);

  final BookDetailsState _self;
  final $Res Function(BookDetailsState) _then;

/// Create a copy of BookDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? errorMessage = freezed,Object? bookDetails = freezed,Object? isLoading = null,Object? bookProgress = null,}) {
  return _then(BookDetailsState(
freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,freezed == bookDetails ? _self.bookDetails : bookDetails // ignore: cast_nullable_to_non_nullable
as BookDetailsUI?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,bookProgress: null == bookProgress ? _self.bookProgress : bookProgress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [BookDetailsState].
extension BookDetailsStatePatterns on BookDetailsState {
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
