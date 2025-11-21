import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/organisms/bottom_tool_bar.dart';
import 'package:mibook/core/routes/app_router.gr.dart';
import 'package:mibook/layers/domain/models/feature.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        ReadingListRoute(),
        BookSearchRoute(),
        FavoriteListRoute(),
        CurrentObjectiveRoute(),
      ],
      transitionBuilder: (context, child, animation) =>
          FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final router = context.tabsRouter;
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: child),
              BottomToolBar(
                selectedIndex: router.activeIndex,
                featureList: [
                  Feature.readingList,
                  Feature.search,
                  Feature.favorite,
                  Feature.objectives,
                ],
                onSelectIndex: router.setActiveIndex,
              ),
            ],
          ),
        );
      },
    );
  }
}
