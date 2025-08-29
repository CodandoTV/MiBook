// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'book_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookSearchState {

 bool get isLoading; String? get errorMessage; String get searchText; List<BookUI> get books; bool get isPageLoading; bool get canLoadNextPage;
/// Create a copy of BookSearchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookSearchStateCopyWith<BookSearchState> get copyWith => _$BookSearchStateCopyWithImpl<BookSearchState>(this as BookSearchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookSearchState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.searchText, searchText) || other.searchText == searchText)&&const DeepCollectionEquality().equals(other.books, books)&&(identical(other.isPageLoading, isPageLoading) || other.isPageLoading == isPageLoading)&&(identical(other.canLoadNextPage, canLoadNextPage) || other.canLoadNextPage == canLoadNextPage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,errorMessage,searchText,const DeepCollectionEquality().hash(books),isPageLoading,canLoadNextPage);

@override
String toString() {
  return 'BookSearchState(isLoading: $isLoading, errorMessage: $errorMessage, searchText: $searchText, books: $books, isPageLoading: $isPageLoading, canLoadNextPage: $canLoadNextPage)';
}


}

/// @nodoc
abstract mixin class $BookSearchStateCopyWith<$Res>  {
  factory $BookSearchStateCopyWith(BookSearchState value, $Res Function(BookSearchState) _then) = _$BookSearchStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, String? errorMessage, String searchText, List<BookUI> books, bool isPageLoading, bool canLoadNextPage
});




}
/// @nodoc
class _$BookSearchStateCopyWithImpl<$Res>
    implements $BookSearchStateCopyWith<$Res> {
  _$BookSearchStateCopyWithImpl(this._self, this._then);

  final BookSearchState _self;
  final $Res Function(BookSearchState) _then;

/// Create a copy of BookSearchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? errorMessage = freezed,Object? searchText = null,Object? books = null,Object? isPageLoading = null,Object? canLoadNextPage = null,}) {
  return _then(BookSearchState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,searchText: null == searchText ? _self.searchText : searchText // ignore: cast_nullable_to_non_nullable
as String,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<BookUI>,isPageLoading: null == isPageLoading ? _self.isPageLoading : isPageLoading // ignore: cast_nullable_to_non_nullable
as bool,canLoadNextPage: null == canLoadNextPage ? _self.canLoadNextPage : canLoadNextPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BookSearchState].
extension BookSearchStatePatterns on BookSearchState {
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
