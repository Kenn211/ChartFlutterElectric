import 'package:flutter/material.dart';
import 'package:test_chart/core.dart';

// ignore: must_be_immutable
class DropDownSelect extends StatelessWidget {
  DropDownSelect(
      {Key? key, required this.listItem, required this.dropDownValue})
      : super(key: key);

  late String dropDownValue;
  final List<String> listItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
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
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2.0),
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
          child: Icon(Icons.keyboard_arrow_down, color: AppColors.primaryColor),
        ),
        isExpanded: true,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        dropdownColor: const Color.fromARGB(255, 253, 254, 253),
        // Array list of items
        items: listItem.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          dropDownValue = newValue!;

          (context as Element).markNeedsBuild(); //Trick setState in Stl
        });
  }
}
