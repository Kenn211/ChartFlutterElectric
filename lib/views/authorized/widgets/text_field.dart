import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget(
      {super.key,
      this.TextController,
      this.text,
      this.inputPass,
      this.actionInput,
      this.focusNode,
      this.obscurText});

  final TextEditingController? TextController;
  final String? text;
  final bool? inputPass;
  final TextInputAction? actionInput;
  final FocusNode? focusNode;
  final bool? obscurText;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          TextField(
            focusNode: widget.focusNode,
            textInputAction: widget.actionInput,
            controller: widget.TextController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.text,
            ),
            obscureText: widget.obscurText == true ? showPassword : false,
          ),
          widget.inputPass == true
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showPassword == false
                          ? const Icon(CupertinoIcons.eye_fill)
                          : const Icon(CupertinoIcons.eye_slash_fill)))
              : const SizedBox(width: 0, height: 0)
        ],
      ),
    );
  }
}
