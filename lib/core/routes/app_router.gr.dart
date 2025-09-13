// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:mibook/layers/presentation/navigation/dashboard/dashboard_page.dart'
    as _i4;
import 'package:mibook/layers/presentation/navigation/tabs/home_tab.dart'
    as _i5;
import 'package:mibook/layers/presentation/navigation/tabs/objective_tab.dart'
    as _i6;
import 'package:mibook/layers/presentation/navigation/tabs/search_tab.dart'
    as _i9;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_page.dart'
    as _i1;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart'
    as _i13;
import 'package:mibook/layers/presentation/screens/booksearch/book_search_page.dart'
    as _i2;
import 'package:mibook/layers/presentation/screens/currentobjective/current_objective_page.dart'
    as _i3;
import 'package:mibook/layers/presentation/screens/onboarding/pre_onboarding_page.dart'
    as _i7;
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_page.dart'
    as _i8;
import 'package:mibook/layers/presentation/screens/startreading/start_reading_page.dart'
    as _i10;

/// generated route for
/// [_i1.BookDetailsPage]
class BookDetailsRoute extends _i11.PageRouteInfo<BookDetailsRouteArgs> {
  BookDetailsRoute({
    _i12.Key? key,
    required String id,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         BookDetailsRoute.name,
         args: BookDetailsRouteArgs(key: key, id: id),
         initialChildren: children,
       );

  static const String name = 'BookDetailsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BookDetailsRouteArgs>();
      return _i1.BookDetailsPage(key: args.key, id: args.id);
    },
  );
}

class BookDetailsRouteArgs {
  const BookDetailsRouteArgs({this.key, required this.id});

  final _i12.Key? key;

  final String id;

  @override
  String toString() {
    return 'BookDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.BookSearchPage]
class BookSearchRoute extends _i11.PageRouteInfo<void> {
  const BookSearchRoute({List<_i11.PageRouteInfo>? children})
    : super(BookSearchRoute.name, initialChildren: children);

  static const String name = 'BookSearchRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.BookSearchPage();
    },
  );
}

/// generated route for
/// [_i3.CurrentObjectivePage]
class CurrentObjectiveRoute extends _i11.PageRouteInfo<void> {
  const CurrentObjectiveRoute({List<_i11.PageRouteInfo>? children})
    : super(CurrentObjectiveRoute.name, initialChildren: children);

  static const String name = 'CurrentObjectiveRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.CurrentObjectivePage();
    },
  );
}

/// generated route for
/// [_i4.DashboardPage]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute({List<_i11.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardPage();
    },
  );
}

/// generated route for
/// [_i5.HomeTab]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeTab();
    },
  );
}

/// generated route for
/// [_i6.ObjectiveTab]
class ObjectiveRoute extends _i11.PageRouteInfo<void> {
  const ObjectiveRoute({List<_i11.PageRouteInfo>? children})
    : super(ObjectiveRoute.name, initialChildren: children);

  static const String name = 'ObjectiveRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.ObjectiveTab();
    },
  );
}

/// generated route for
/// [_i7.PreOnboardingPage]
class PreOnboardingRoute extends _i11.PageRouteInfo<void> {
  const PreOnboardingRoute({List<_i11.PageRouteInfo>? children})
    : super(PreOnboardingRoute.name, initialChildren: children);

  static const String name = 'PreOnboardingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.PreOnboardingPage();
    },
  );
}

/// generated route for
/// [_i8.ReadingListPage]
class ReadingListRoute extends _i11.PageRouteInfo<void> {
  const ReadingListRoute({List<_i11.PageRouteInfo>? children})
    : super(ReadingListRoute.name, initialChildren: children);

  static const String name = 'ReadingListRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.ReadingListPage();
    },
  );
}

/// generated route for
/// [_i9.SearchTab]
class SearchRoute extends _i11.PageRouteInfo<void> {
  const SearchRoute({List<_i11.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SearchTab();
    },
  );
}

/// generated route for
/// [_i10.StartReadingPage]
class StartReadingRoute extends _i11.PageRouteInfo<StartReadingRouteArgs> {
  StartReadingRoute({
    _i12.Key? key,
    required _i13.BookDetailsUI book,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         StartReadingRoute.name,
         args: StartReadingRouteArgs(key: key, book: book),
         initialChildren: children,
       );

  static const String name = 'StartReadingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<StartReadingRouteArgs>();
      return _i10.StartReadingPage(key: args.key, book: args.book);
    },
  );
}

class StartReadingRouteArgs {
  const StartReadingRouteArgs({this.key, required this.book});

  final _i12.Key? key;

  final _i13.BookDetailsUI book;

  @override
  String toString() {
    return 'StartReadingRouteArgs{key: $key, book: $book}';
  }
}
