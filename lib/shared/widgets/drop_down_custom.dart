import 'dart:collection';

import 'package:flutter/material.dart';
import '../../core.dart';

// ignore: must_be_immutable
class DropDownSelect extends StatelessWidget {
  DropDownSelect(
      {required this.listItem,
      required this.dropDownValue,
      required this.onChanged,
      Key? key})
      : super(key: key);

  late String dropDownValue;
  final ValueChanged<String?> onChanged;
  final Map<String, dynamic> listItem;

  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      delay: const Duration(milliseconds: 300),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          style: TextStyle(
              color: AppColors.secondColor, //<-- SEE HERE
              fontSize: 16,
              fontWeight: FontWeight.bold),
          menuMaxHeight: 400,
          value: dropDownValue,
          focusColor: Colors.transparent,
          // Down Arrow Icon
          icon: Container(
            alignment: Alignment.centerRight,
            child:
                Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
          ),
          isExpanded: true,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          dropdownColor: const Color.fromARGB(255, 253, 254, 253),
          // Array list of items
          items: _buildDropdownMenuItems(dropdownList: listItem),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (newValue) {
            onChanged(newValue);
            dropDownValue = newValue!;

            // (context as Element).markNeedsBuild(); //Trick setState in Stl
          }),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownMenuItems(
      {required Map<String, dynamic> dropdownList}) {
    final list = <DropdownMenuItem<String>>[];
    LinkedHashMap.from(dropdownList).forEach((key, value) {
      list.add(DropdownMenuItem<String>(
        alignment: AlignmentDirectional.centerStart,
        value: key,
        child: Text(key),
      ));
    });
    return list;
  }
}
