part of 'helpers.dart';

Route navigationFadeIn(BuildContext context, Widget pageToNavigate) {
  return PageRouteBuilder(pageBuilder: (_, __, ___) => pageToNavigate,
    transitionDuration: Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, _, child ) {
      return FadeTransition(
        child: child,
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut
            )
          )
      );
    }
  );
}