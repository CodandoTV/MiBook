import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ReadingListPage extends StatelessWidget {
  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Reading List'),
    );
  }
}
