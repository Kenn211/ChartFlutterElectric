import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core.dart';

class Button extends StatelessWidget {
  const Button(
      {required this.text,
      required this.onTap,
      super.key,
      this.showIcon = true});

  final String text;
  final Function()? onTap;
  final bool? showIcon;

  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      delay: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 63, 160, 239),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: ElevatedButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showIcon == true)
                const Icon(CupertinoIcons.refresh_circled)
              else
                const SizedBox(height: 0, width: 0),
              const SizedBox(
                width: 5,
              ),
              Text(text)
            ],
          ),
        ),
      ),
    );
  }
}
