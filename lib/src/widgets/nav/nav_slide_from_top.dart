part of 'nav.dart';

class NavSlideFromTop extends PageRouteBuilder {
  final Widget page;

  NavSlideFromTop({required this.page})
      : super(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return page;
            },
            transitionDuration: new Duration(milliseconds: 380),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, -1.0),
                  end: const Offset(0.0, 0.0),
                ).animate(animation),
                child: child,
              );
            });
}
