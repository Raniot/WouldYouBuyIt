import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageLayout extends StatelessWidget {
  const PageLayout({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: child,
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        body: child,
      );
    }
  }
}
