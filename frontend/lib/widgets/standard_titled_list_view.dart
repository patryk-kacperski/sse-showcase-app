import 'package:flutter/material.dart';

class StandardTitledListView extends StatelessWidget {
  const StandardTitledListView({
    super.key,
    required this.title,
    this.titleStyle,
    required this.itemCount,
    required this.itemBuilder,
  });

  final String title;
  final TextStyle? titleStyle;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:
              titleStyle ??
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          ),
        ),
      ],
    );
  }
}
