import 'package:auto_route/auto_route.dart';
import 'package:mibook/core/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DashboardRoute.page,
      initial: true,
      children: [
        AutoRoute(
          page: HomeTab.page,
          children: [AutoRoute(page: ReadingListRoute.page)],
        ),
        AutoRoute(
          page: SearchTab.page,
          children: [AutoRoute(page: BookSearchRoute.page)],
        ),
        AutoRoute(
          page: ObjectiveTab.page,
          children: [AutoRoute(page: CurrentObjectiveRoute.page)],
        ),
      ],
    ),
  ];
}
