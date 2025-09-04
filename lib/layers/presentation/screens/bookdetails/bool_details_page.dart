import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_state.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_view_model.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_event.dart';

@RoutePage()
class BoolDetailsPage extends StatelessWidget {
  final String id;

  const BoolDetailsPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<BookDetailsViewModel>(param1: id)..add(DidLoadEvent(id)),
      child: _BookDetailsScaffold(id),
    );
  }
}

class _BookDetailsScaffold extends StatelessWidget {
  final String id;
  const _BookDetailsScaffold(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<BookDetailsViewModel, BookDetailsState>(
          builder: (context, state) {
            return AppNavBar(
              titleText: state.bookDetails?.title ?? 'Loading...',
              isTitleLoading: state.isLoading,
              onBack: context.router.maybePop,
            );
          },
        ),
      ),
      body: _BookDetailsContent(),
    );
  }
}

class _BookDetailsContent extends StatelessWidget {
  const _BookDetailsContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<BookDetailsViewModel, BookDetailsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.errorMessage != null) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else if (state.bookDetails != null) {
                final book = state.bookDetails!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (book.thumbnail != null)
                        Image.network(book.thumbnail!),
                      const SizedBox(height: 16),
                      Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (book.authors.isNotEmpty)
                        Text(
                          'By ${book.authors}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      const SizedBox(height: 16),
                      Html(data: book.description),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('No data available.'));
              }
            },
          ),
        ],
      ),
    );
  }
}
