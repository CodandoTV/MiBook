import 'package:flutter/material.dart';
import 'package:mibook/core/utils/strings.dart' as strings;
import 'package:mibook/layers/domain/models/feature.dart';

extension FeatureUtils on Feature {
  String get optionTitle {
    switch (this) {
      case Feature.readingList:
        return strings.home;
      case Feature.search:
        return strings.search;
      case Feature.objectives:
        return strings.objectives;
      case Feature.favorite:
        return strings.favorite;
    }
  }

  IconData get icon {
    switch (this) {
      case Feature.readingList:
        return Icons.home;
      case Feature.search:
        return Icons.search_outlined;
      case Feature.objectives:
        return Icons.book;
      case Feature.favorite:
        return Icons.favorite;
    }
  }
}
