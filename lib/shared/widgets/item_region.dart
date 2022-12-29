import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemRegions extends StatelessWidget {
  const ItemRegions({super.key, required this.colorRe, required this.text});

  final Color colorRe;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 25,
          height: 8,
          color: colorRe,
        ),
        const SizedBox(height: 5),
        Text(text)
      ],
    );
  }
}
