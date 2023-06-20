import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/widgets/design/platform.dart';

class Loader extends PlatformWidget<CupertinoActivityIndicator, CircularProgressIndicator> {
  @override
  CircularProgressIndicator createAndroidWidget(BuildContext context) => CircularProgressIndicator();

  @override
  CupertinoActivityIndicator createIosWidget(BuildContext context) => CupertinoActivityIndicator();

}