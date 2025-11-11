import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mibook/core/designsystem/molecules/buttons/primary_button.dart';
import 'package:mibook/core/designsystem/molecules/buttons/secondary_button.dart';
import 'package:mibook/core/designsystem/molecules/indicators/progress_stepper.dart';
import 'package:mibook/core/designsystem/molecules/inputfields/input_field.dart';
import 'package:mibook/core/designsystem/organisms/app_nav_bar.dart';
import 'package:mibook/core/designsystem/organisms/show_error_dialog.dart';
import 'package:mibook/core/di/di.dart';
import 'package:mibook/core/utils/strings.dart';
import 'package:mibook/core/utils/strings.dart' as strings;
import 'package:mibook/layers/presentation/screens/bookdetails/book_details_ui.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_event.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_state.dart';
import 'package:mibook/layers/presentation/screens/startreading/start_reading_view_model.dart';

typedef _BlocListener = BlocListener<StartReadingViewModel, StartReadingState>;
typedef _BlocBuilder = BlocBuilder<StartReadingViewModel, StartReadingState>;

@RoutePage()
class StartReadingPage extends StatelessWidget {
  final BookDetailsUI book;

  const StartReadingPage({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<StartReadingViewModel>(param1: book),
      child: _StartReadingScaffold(),
    );
  }
}

class _StartReadingScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<StartReadingViewModel>();

    return _BlocListener(
      bloc: viewModel,
      listenWhen: (previous, current) =>
          previous.shouldShowSavingError != current.shouldShowSavingError &&
          current.shouldShowSavingError,
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showErrorDialog(
            context,
            'Error',
            'An error occurred while saving your reading progress. Please try again.',
            'OK',
            () {
              viewModel.add(DidClickSavingErrorDismissEvent());
            },
          );
        });
      },
      child: Scaffold(
        appBar: AppNavBar(
          titleText: startReading,
          onBack: context.router.maybePop,
        ),
        body: _BlocBuilder(
          builder: (context, state) {
            final viewModel = context.read<StartReadingViewModel>();
            if (state.shouldNavigateBack) {
              context.router.maybePop();
            }
            return _StartReadingContent(
              book: viewModel.book,
              progress: state.progress,
              errorMessage: state.inputErrorMessage,
              onChangeProgressText: (progress) {
                viewModel.add(
                  DidEditProgressEvent(
                    progress: int.tryParse(progress) ?? 0,
                  ),
                );
              },
              onClickStartReading: () {
                viewModel.add(DidClickConfirmEvent());
              },
              onClickFinishBook: () {
                viewModel.add(DidClickFinishBookEvent());
              },
            );
          },
        ),
      ),
    );
  }
}

class _StartReadingContent extends StatelessWidget {
  final BookDetailsUI book;
  final double progress;
  final String? errorMessage;
  final TextEditingController _controller = TextEditingController();
  final Function(String) onChangeProgressText;
  final Function onClickStartReading;
  final Function onClickFinishBook;

  _StartReadingContent({
    required this.book,
    required this.progress,
    required this.errorMessage,
    required this.onChangeProgressText,
    required this.onClickStartReading,
    required this.onClickFinishBook,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
          Text('Maximum pages: ${book.pageCount}'),
          const SizedBox(height: 24),
          InputField(
            keyboardType: TextInputType.number,
            label: strings.progress,
            controller: _controller,
            onChanged: onChangeProgressText,
            placeholder: strings.zero,
            errorMessage: errorMessage,
          ),
          const SizedBox(height: 24),
          ProgressStepper(progress: progress),
          const SizedBox(
            height: 24,
          ),
          const Spacer(),
          PrimaryButton(
            title: strings.confirm,
            isEnabled: errorMessage == null,
            isExpanded: true,
            onPressed: onClickStartReading as VoidCallback,
          ),
          const SizedBox(
            height: 16,
          ),
          SecondaryButton(
            title: finishBook,
            isExpanded: true,
            onPressed: onClickFinishBook as VoidCallback,
          ),
        ],
      ),
    );
  }
}
