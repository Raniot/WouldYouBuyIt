import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/widgets/design/platform.dart';

class TextInput extends PlatformWidget<CupertinoTextField, TextField> {
  @override
  TextField createAndroidWidget(BuildContext context) => TextField(

  );

  @override
  CupertinoTextField createIosWidget(BuildContext context) => CupertinoTextField(

  );
}