import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mibook/core/designsystem/molecules/buttons/primary_button.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/designsystem/organisms/list_item.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/core/utils/strings.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_state.dart';
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
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
                        title: startReading,
                        onPressed: () => showGeneralDialog(
                          context: context,
                          barrierDismissible:
                              true, // allows tap outside to close
                          barrierLabel: "Dismiss",
                          barrierColor: Colors.black54, // dim background
                          transitionDuration: const Duration(milliseconds: 300),
                          pageBuilder: (context, anim1, anim2) {
                            // Must return a full-screen widget so barrier can detect taps
                            return SafeArea(
                              child: Builder(
                                builder: (context) {
                                  return Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: AlertDialog(
                                        content: _StartReadingDialogContent(
                                          book: book,
                                          onClickStartReading:
                                              (double progress) {
                                                Navigator.of(context).pop();
                                              },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          transitionBuilder: (context, anim1, anim2, child) {
                            // Slide + fade
                            return SlideTransition(
                              position: Tween(
                                begin: const Offset(0, 0.2), // from bottom
                                end: Offset.zero,
                              ).animate(anim1),
                              child: FadeTransition(
                                opacity: anim1,
                                child: child,
                              ),
                            );
                          },
                        ),
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
  final Function(double) onClickStartReading;

  const _StartReadingDialogContent({
    required this.book,
    required this.onClickStartReading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
      ],
    );
  }
}
