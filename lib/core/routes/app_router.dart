import 'package:auto_route/auto_route.dart';
import 'package:mibook/core/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Tab|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: PreOnboardingRoute.page),
    AutoRoute(
      page: DashboardRoute.page,
      initial: true,
      children: [
        AutoRoute(
          page: HomeRoute.page,
          children: [AutoRoute(page: ReadingListRoute.page)],
        ),
        AutoRoute(
          page: SearchRoute.page,
          children: [
            AutoRoute(page: BookSearchRoute.page),
            AutoRoute(page: BoolDetailsRoute.page),
          ],
        ),
        AutoRoute(
          page: ObjectiveRoute.page,
          children: [AutoRoute(page: CurrentObjectiveRoute.page)],
        ),
      ],
    ),
  ];
}
