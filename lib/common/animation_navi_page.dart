import 'package:flutter/material.dart';

Route createRoute({required Widget screens}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        screens,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 0.6);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}