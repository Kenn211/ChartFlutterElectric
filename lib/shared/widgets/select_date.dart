import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_chart/core.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({super.key, this.isStack = false, this.onTap, this.text});
  final bool? isStack;
  final Function()? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(width: 1, color: AppColors.secondColor)),
          child: Row(
            mainAxisAlignment: isStack == true
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Colors.black.withOpacity(0.6),
              ),
              const SizedBox(width: 5),
              Row(children: [
                SizedBox(
                  child: Text(text!,
                      style: TextStyle(color: Colors.black.withOpacity(0.6))),
                ),
              ])
            ],
          ),
        ));
  }
}
