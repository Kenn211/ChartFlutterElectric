import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // final tween = TimelineTween<AniProp>()
    //   ..addScene(begin: Duration.zero, end: const Duration(milliseconds: 500))
    //       .animate(AniProp.opacity, tween: Tween(begin: 0.0, end: 1.0))
    //       .animate(
    //         AniProp.translateY,
    //         tween: Tween(begin: -30.0, end: 0.0),
    //         curve: Curves.easeOut,
    //       );

    // return PlayAnimation<TimelineValue<AniProp>>(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builder: (context, child, animation) => Opacity(
    //     opacity: animation.get<double>(AniProp.opacity),
    //     child: Transform.translate(
    //       offset: Offset(0, animation.get<double>(AniProp.translateY)),
    //       child: child,
    //     ),
    //   ),
    // );
    return child;
  }
}
