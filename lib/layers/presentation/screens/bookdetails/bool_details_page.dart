import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              titleText: state.bookDetails?.title ?? "Loading...",
              onBack: context.router.maybePop,
            );
          },
        ),
      ),
      body: Container(),
    );
  }
}
