import 'package:flutter/material.dart';

class TableCustom extends StatelessWidget {
  const TableCustom(
      {super.key, required this.textTable, this.colorText = false});

  final String textTable;
  final bool colorText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Text(
        textTable,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: colorText == true ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16),
      ),
    );
  }
}
