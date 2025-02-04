import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageTransitions {
  static PageTransition<dynamic> bottomToTop({required Widget child}) {
    return PageTransition(
      type: PageTransitionType.bottomToTop,
      child: child,
    );
  }
}
