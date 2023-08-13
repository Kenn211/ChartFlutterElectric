import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({super.key, this.isStack = false, this.onTap, this.text});
  final bool? isStack;
  final Function()? onTap;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      delay: const Duration(milliseconds: 300),
      child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(width: 2, color: AppColors.primaryColor),
            ),
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
                SizedBox(
                  child: Text(text!,
                      style: TextStyle(color: AppColors.secondColor)),
                ),
              ],
            ),
          )),
    );
  }
}
