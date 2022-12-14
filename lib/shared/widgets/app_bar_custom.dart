import 'package:flutter/material.dart';
import 'package:test_chart/shared/constants/colors.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom(
      {super.key,
      this.canBack = false,
      this.leading,
      this.title,
      this.elevationCus});

  final bool canBack;
  final Widget? leading;
  final String? title;
  final double? elevationCus;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: elevationCus ?? 1,
        leading: canBack == true
            ? IconButton(
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                disabledColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios, color: AppColors.secondColor))
            : leading,
        title: Container(
          width: double.infinity,
          child: Text(
            title ?? '',
            style: TextStyle(color: AppColors.secondColor),
          ),
        ));
    return SizedBox(
      width: double.infinity,
      child: appBar,
    );
  }
}
