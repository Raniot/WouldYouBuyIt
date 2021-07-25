import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showGuessDialog(BuildContext context, int guess, int actualPrice) async {
  return showDialog<void>(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: const Text('Result'),
        content: Text('You guess: $guess\n Real price: $actualPrice\nYou were off by ${(actualPrice - guess).abs()}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            child: const Text('OK')
          )
        ],
      );
    }
  );
}