import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';

abstract class ListItemInput {
  Widget get content;
}

class BookItemInput extends ListItemInput {
  final String id;
  final String kind;
  final String title;
  final String authors;
  final String description;
  final String? thumbnail;

  BookItemInput({
    required this.id,
    required this.kind,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnail,
  });

  @override
  Widget get content {
    return Row(
      children: [
        if (thumbnail != null)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              width: 32,
              height: 32,
              child: Image.network(
                thumbnail!,
                width: 50,
                height: 75,
                fit: BoxFit.cover,
              ),
            ),
          ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (authors.isNotEmpty) Text('Authors: $authors'),
            ],
          ),
        ),
      ],
    );
  }
}

class GenericInput extends ListItemInput {
  final Widget child;

  GenericInput({required this.child});

  @override
  Widget get content => child;
}

class ListItem extends StatelessWidget {
  final ListItemInput input;
  final Function()? onTap;

  const ListItem({
    super.key,
    required this.input,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: onBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: input.content,
        ),
      ),
    );
  }
}
