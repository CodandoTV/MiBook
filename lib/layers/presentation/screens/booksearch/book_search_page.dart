import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BookSearchPage extends StatelessWidget {
  const BookSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const Text('Book Search page'));
  }
}
