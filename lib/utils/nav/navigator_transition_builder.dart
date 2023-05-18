import 'package:flutter/material.dart';

class NavigatorTransitionBuilder {
  static PageRouteBuilder buildSlideHTransition(Widget screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      // transitionsBuilder: (context, animation, secondaryAnimation, child) =>
      //     const FadeTransitionsBuilder().buildTransitions(null, context, animation, secondaryAnimation, child),
    );
  }
}
