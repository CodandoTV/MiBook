import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mibook/core/designsystem/molecules/buttons/primary_button.dart';
import 'package:mibook/core/designsystem/molecules/indicators/progress_stepper.dart';
import 'package:mibook/core/designsystem/molecules/inputfields/input_field.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/designsystem/organisms/list_item.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/core/routes/app_router.gr.dart';
import 'package:mibook/core/utils/strings.dart' as strings;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_state.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_view_model.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_event.dart';

@RoutePage()
class BookDetailsPage extends StatelessWidget {
  final String id;

  const BookDetailsPage({
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
    final viewModel = context.read<BookDetailsViewModel>();
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
                final bookProgress = state.bookProgress;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (book.thumbnail != null)
                        CachedNetworkImage(imageUrl: book.thumbnail!),
                      const SizedBox(height: 16),
                      ListItem(
                        isExpanded: true,
                        input: GenericInput(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                        ),
                      ),
                      const SizedBox(height: 24),
                      PrimaryButton(
                        title: strings.startReading,
                        onPressed: () {
                          if (state.bookDetails != null) {
                            context.router.push(
                              StartReadingRoute(book: state.bookDetails!),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 32),
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

class _StartReadingDialogContent extends StatelessWidget {
  final BookDetailsUI book;
  final double progress;
  final TextEditingController _controller = TextEditingController();
  final Function(String) onChangeProgressText;
  final Function(double) onClickStartReading;

  _StartReadingDialogContent({
    required this.book,
    required this.progress,
    required this.onChangeProgressText,
    required this.onClickStartReading,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('Progress $progress');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          if (book.thumbnail != null)
            CachedNetworkImage(imageUrl: book.thumbnail!),
          const SizedBox(height: 16),
          Text(
            book.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text('Maximum pages: ${book.pageCount}'),
          const SizedBox(height: 24),
          InputField(
            keyboardType: TextInputType.number,
            label: strings.progress,
            controller: _controller,
            onChanged: onChangeProgressText,
          ),
          const SizedBox(height: 24),
          ProgressStepper(progress: progress),
          const SizedBox(height: 24),
          PrimaryButton(
            title: strings.confirm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
