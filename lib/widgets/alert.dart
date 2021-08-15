import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showGuessDialog(BuildContext context, int guess, int actualPrice, int score) async {
  return showDialog<void>(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: const Text('Result'),
        content: Text('You guess: ${format(guess)}\nReal price: ${format(actualPrice)}\nYou were off by ${format((actualPrice - guess).abs())}\n\nYour avg score is: ${format(score)}'),
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

String format(int value) {
  return '${NumberFormat('###,###').format(value)} kr.';
}