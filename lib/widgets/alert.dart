import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showGuessDialog(BuildContext context, num guess, num actualPrice, num score) async {
  return showDialog<void>(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: const Text('Result'),
        content: Text('You guess: ${format(guess)} kr.\nReal price: ${format(actualPrice)} kr.\nYou were off by ${format((actualPrice - guess).abs())} kr.\n\nYour avg score is: ${format(score)}'),
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

String format(num value) {
  return '${NumberFormat('###,###').format(value)}';
}