import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/core/designsystem/molecules/buttons/primary_button.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/designsystem/organisms/list_item.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_event.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_state.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_ui.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_view_model.dart';

const _title = "Your Reading List";
const _emptyListMessage = "Your reading list is empty.";
const _searchBooks = "Search a book";
const _startIndex = 0;
const _searchTabIndex = 1;

typedef _BlocBuilder = BlocBuilder<ReadingListViewModel, ReadingListState>;

@RoutePage()
class ReadingListPage extends StatelessWidget {
  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReadingListViewModel>(),
      child: const _ReadingListScaffold(),
    );
  }
}

class _ReadingListScaffold extends StatelessWidget {
  const _ReadingListScaffold();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ReadingListViewModel>();
      viewModel.add(
        WatchReadingListEvent(),
      );
    });
    return Scaffold(
      appBar: AppNavBar(
        titleText: _title,
        textAlignment: AppNavBarTextAlignment.center,
      ),
      body: const _ReadingListContent(),
    );
  }
}

class _ReadingListContent extends StatelessWidget {
  const _ReadingListContent();

  @override
  Widget build(BuildContext context) {
    return _BlocBuilder(
      builder: (context, state) {
        if (state.readings.isEmpty) {
          return _EmptyReadingList();
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _ReadingListSection(
            title: _title,
            items: state.readings,
          ),
        );
      },
    );
  }
}

class _EmptyReadingList extends StatelessWidget {
  const _EmptyReadingList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_emptyListMessage),
          const SizedBox(height: 12),
          PrimaryButton(
            title: _searchBooks,
            onPressed: () {
              context.tabsRouter.setActiveIndex(_searchTabIndex);
            },
          ),
        ],
      ),
    );
  }
}

class _ReadingListSection extends StatelessWidget {
  final String title;
  final List<ReadingUI> items;

  const _ReadingListSection({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == _startIndex) {
          return Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }
        final item = items[index - 1];
        return ListItem(
          input: TitleImageProgressInput(
            title: item.bookName,
            progress: item.progress,
            thumbnail: item.thumbnail,
          ),
        );
      },
    );
  }
}
