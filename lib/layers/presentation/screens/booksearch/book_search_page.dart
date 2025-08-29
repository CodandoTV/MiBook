import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/core/designsystem/molecules/buttons/primary_button.dart';
import 'package:mibook/core/designsystem/molecules/inputfields/input_field.dart';
import 'package:mibook/core/di/di.dart';
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
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          Expanded(
            child: BlocBuilder<BookSearchViewModel, BookSearchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.errorMessage != null) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                } else if (state.books.isEmpty) {
                  return const Center(child: Text('No books found'));
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.isPageLoading
                        ? state.books.length + 1
                        : state.books.length,
                    itemBuilder: (context, index) {
                      if (state.isPageLoading && index == state.books.length) {
                        return _progressIndicator();
                      }
                      final book = state.books[index];
                      if (index == state.books.length - 1 &&
                          !state.isPageLoading &&
                          state.canLoadNextPage) {
                        viewModel.add(DidFinishPageEvent());
                      }
                      return ListTile(
                        leading: book.thumbnail != null
                            ? Image.network(book.thumbnail!)
                            : const Icon(Icons.book),
                        title: Text(book.title),
                        subtitle: Text(book.authors),
                      );
                    },
                  );
                }
              },
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
