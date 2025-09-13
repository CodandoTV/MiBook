import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/core/designsystem/molecules/buttons/primary_button.dart';
import 'package:mibook/core/designsystem/molecules/inputfields/input_field.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/designsystem/organisms/list_item.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/core/routes/app_router.gr.dart';
import 'package:mibook/core/utils/strings.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_event.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_state.dart';
import 'package:mibook/layers/presentation/screens/booksearch/book_search_view_model.dart';

@RoutePage()
class BookSearchPage extends StatelessWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<BookSearchViewModel>(),
      child: _SearchScaffold(),
    );
  }
}

class _SearchScaffold extends StatelessWidget {
  final _scrollController = ScrollController();

  _SearchScaffold();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BookSearchViewModel>();
    final controller = TextEditingController(text: viewModel.state.searchText);

    return Scaffold(
      appBar: AppNavBar(
        titleText: 'Search Books',
        textAlignment: AppNavBarTextAlignment.start,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    label: '',
                    controller: controller,
                    isEnabled: !viewModel.state.isLoading,
                    placeholder: searchBooks,
                    onChanged: (text) {
                      viewModel.add(DidChangeSearchTextEvent(text));
                    },
                  ),
                ),
                const SizedBox(width: 8),
                BlocBuilder<BookSearchViewModel, BookSearchState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      title: search,
                      isLoading: state.isLoading,
                      isEnabled: state.searchText.isNotEmpty,
                      onPressed: () {
                        viewModel.add(DidClickSearchEvent());
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: BlocBuilder<BookSearchViewModel, BookSearchState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  } else if (state.errorMessage != null) {
                    return Text('Error: ${state.errorMessage}');
                  } else if (state.books.isEmpty) {
                    return const Text('No books found');
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.isPageLoading
                          ? state.books.length + 1
                          : state.books.length,
                      itemBuilder: (context, index) {
                        if (state.isPageLoading &&
                            index == state.books.length) {
                          return _progressIndicator();
                        }
                        final book = state.books[index];
                        if (index == state.books.length - 1 &&
                            !state.isPageLoading &&
                            state.canLoadNextPage) {
                          viewModel.add(DidFinishPageEvent());
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: ListItem(
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
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
