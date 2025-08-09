// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:mibook/layers/presentation/navigation/dashboard/dashboard_page.dart'
    as _i3;
import 'package:mibook/layers/presentation/navigation/tabs/home_tab.dart'
    as _i4;
import 'package:mibook/layers/presentation/navigation/tabs/objective_tab.dart'
    as _i5;
import 'package:mibook/layers/presentation/navigation/tabs/search_tab.dart'
    as _i7;
import 'package:mibook/layers/presentation/screens/booksearch/book_search_page.dart'
    as _i1;
import 'package:mibook/layers/presentation/screens/currentobjective/current_objective_page.dart'
    as _i2;
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_page.dart'
    as _i6;

/// generated route for
/// [_i1.BookSearchPage]
class BookSearchRoute extends _i8.PageRouteInfo<void> {
  const BookSearchRoute({List<_i8.PageRouteInfo>? children})
    : super(BookSearchRoute.name, initialChildren: children);

  static const String name = 'BookSearchRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.BookSearchPage();
    },
  );
}

/// generated route for
/// [_i2.CurrentObjectivePage]
class CurrentObjectiveRoute extends _i8.PageRouteInfo<void> {
  const CurrentObjectiveRoute({List<_i8.PageRouteInfo>? children})
    : super(CurrentObjectiveRoute.name, initialChildren: children);

  static const String name = 'CurrentObjectiveRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.CurrentObjectivePage();
    },
  );
}

/// generated route for
/// [_i3.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute({List<_i8.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardPage();
    },
  );
}

/// generated route for
/// [_i4.HomeTab]
class HomeTab extends _i8.PageRouteInfo<void> {
  const HomeTab({List<_i8.PageRouteInfo>? children})
    : super(HomeTab.name, initialChildren: children);

  static const String name = 'HomeTab';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeTab();
    },
  );
}

/// generated route for
/// [_i5.ObjectiveTab]
class ObjectiveTab extends _i8.PageRouteInfo<void> {
  const ObjectiveTab({List<_i8.PageRouteInfo>? children})
    : super(ObjectiveTab.name, initialChildren: children);

  static const String name = 'ObjectiveTab';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i5.ObjectiveTab();
    },
  );
}

/// generated route for
/// [_i6.ReadingListPage]
class ReadingListRoute extends _i8.PageRouteInfo<void> {
  const ReadingListRoute({List<_i8.PageRouteInfo>? children})
    : super(ReadingListRoute.name, initialChildren: children);

  static const String name = 'ReadingListRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.ReadingListPage();
    },
  );
}

/// generated route for
/// [_i7.SearchTab]
class SearchTab extends _i8.PageRouteInfo<void> {
  const SearchTab({List<_i8.PageRouteInfo>? children})
    : super(SearchTab.name, initialChildren: children);

  static const String name = 'SearchTab';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SearchTab();
    },
  );
}
