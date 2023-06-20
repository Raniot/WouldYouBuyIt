import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/widgets/design/platform.dart';

class Button extends PlatformWidget<CupertinoButton, OutlinedButton> {
  Button({
    this.onPressed,
    required this.child,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  OutlinedButton createAndroidWidget(BuildContext context) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: onPressed?.call,
        child: child,
      );

  @override
  CupertinoButton createIosWidget(BuildContext context) => CupertinoButton(
        onPressed: onPressed?.call,
        child: child,
      );
}
