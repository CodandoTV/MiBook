import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_event.dart';
import 'package:mibook/layers/presentation/screens/readinglist/reading_list_view_model.dart';

const _title = "Your Reading List";

@RoutePage()
class ReadingListPage extends StatelessWidget {
  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ReadingListViewModel>(),
      child: const ReadingListScaffold(),
    );
  }
}

class ReadingListScaffold extends StatelessWidget {
  const ReadingListScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<ReadingListViewModel>();
      viewModel.add(
        LoadReadingListEvent(),
      );
    });
    return Scaffold(
      appBar: AppNavBar(
        titleText: _title,
        textAlignment: AppNavBarTextAlignment.center,
      ),
      body: const ReadingListContent(),
    );
  }
}

class ReadingListContent extends StatelessWidget {
  const ReadingListContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
