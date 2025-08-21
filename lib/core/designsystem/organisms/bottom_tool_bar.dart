import 'package:flutter/material.dart';
import 'package:mibook/core/designsystem/atoms/colors.dart' as colors;
import 'package:mibook/layers/domain/models/feature.dart';
import 'package:mibook/layers/presentation/navigation/dashboard/feature.dart';

class BottomToolBar extends StatelessWidget {
  final int selectedIndex;
  final List<Feature> featureList;
  final Function(int) onSelectIndex;

  const BottomToolBar({
    super.key,
    required this.selectedIndex,
    required this.featureList,
    required this.onSelectIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white, // or your theme background color
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // subtle shadow
            offset: Offset(0, 1), // negative y = shadow at the top
            blurRadius: 3, // how soft the shadow looks
            spreadRadius: 0, // keep it tight
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: featureList
              .asMap()
              .entries
              .map(
                (elem) => _tabItem(
                  elem.value,
                  selectedIndex == elem.key,
                  elem.key,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _tabItem(
    Feature feature,
    bool isSelected,
    int index,
  ) {
    return InkWell(
      onTap: () {
        onSelectIndex(index);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            feature.icon,
            color: isSelected ? colors.primary : colors.disabled,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            feature.optionTitle,
            style: TextStyle(
              color: isSelected ? colors.primary : colors.disabled,
            ),
          ),
        ],
      ),
    );
  }
}
