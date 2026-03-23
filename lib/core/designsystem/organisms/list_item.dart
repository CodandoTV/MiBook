import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart';
import 'package:mibook/core/designsystem/molecules/indicators/progress_stepper.dart';

abstract class ListItemInput {
  Widget get content;
}

class TitleImageDescriptionInput extends ListItemInput {
  final String id;
  final String kind;
  final String title;
  final String authors;
  final String description;
  final String? thumbnail;

  TitleImageDescriptionInput({
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

class TitleImageProgressInput extends ListItemInput {
  final String title;
  final String? thumbnail;
  final double progress; // value between 0.0 and 1.0

  TitleImageProgressInput({
    required this.title,
    required this.progress,
    this.thumbnail,
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
              const SizedBox(height: 8),
              ProgressStepper(progress: progress),
            ],
          ),
        ),
      ],
    );
  }
}

class TitleSubtitleHtmlDescriptionInput extends ListItemInput {
  final String title;
  final String subtitle;
  final String description;

  TitleSubtitleHtmlDescriptionInput({
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget get content {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        const SizedBox(height: 16),
        Html(data: description),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final ListItemInput input;
  final bool isExpanded;
  final Function()? onTap;

  const ListItem({
    super.key,
    required this.input,
    this.isExpanded = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: isExpanded ? double.infinity : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: onBackground,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: input.content,
        ),
      ),
    );
  }
}
