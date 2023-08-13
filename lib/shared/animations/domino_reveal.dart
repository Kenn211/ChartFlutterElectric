import 'dart:async';

import 'package:flutter/material.dart';

import './delayed_reveal.dart';

// This function increments and returns a Duration
// The delay is reset when no new animations have been added for a short moment
//  (you can change the conditions of this to match your requirements)
late Timer _dominoReset;
Duration _dominoDelay = const Duration();
Duration _getDelay() {
  if (!_dominoReset.isActive) {
    _dominoReset = Timer(const Duration(milliseconds: 100), () {
      _dominoDelay = const Duration();
    });
  }
  // ignore: join_return_with_assignment
  _dominoDelay += const Duration(milliseconds: 100);
  return _dominoDelay;
}

class DominoReveal extends StatelessWidget {
  const DominoReveal({
    required this.child,
    Key? key,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DelayedReveal(
      delay: _getDelay(),
      child: child,
    );
  }
}
