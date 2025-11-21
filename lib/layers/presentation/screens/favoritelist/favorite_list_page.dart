import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/designsystem/organisms/list_item.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/core/routes/app_router.gr.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_event.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_state.dart';
import 'package:mibook/layers/presentation/screens/favoritelist/favorite_list_view_model.dart';

typedef _BlocBuilder = BlocBuilder<FavoriteListViewModel, FavoriteListState>;

@RoutePage()
class FavoriteListPage extends StatelessWidget {
  const FavoriteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FavoriteListViewModel>(),
      child: const FavoriteListScaffold(),
    );
  }
}

class FavoriteListScaffold extends StatelessWidget {
  const FavoriteListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<FavoriteListViewModel>();
      viewModel.add(
        DidAppearEvent(),
      );
    });
    return Scaffold(
      appBar: AppNavBar(
        titleText: 'Favorite Books',
        textAlignment: AppNavBarTextAlignment.center,
      ),
      body: _BlocBuilder(
        builder: (context, state) {
          final viewModel = context.read<FavoriteListViewModel>();
          return RefreshIndicator(
            onRefresh: () async {
              viewModel.add(DidRefreshEvent());
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return ListItem(
                    onTap: () => context.router.push(
                      BookDetailsRoute(id: book.id),
                    ),
                    input: BookItemInput(
                      id: book.id,
                      kind: book.kind,
                      title: book.title,
                      authors: book.authors,
                      description: book.description,
                      thumbnail: book.thumbnail,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
