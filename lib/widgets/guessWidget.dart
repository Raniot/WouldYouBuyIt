import 'package:flutter/material.dart';

class Guess extends StatelessWidget {
  Function() onPressed;

  Guess({
    required this.onPressed
  });
  
  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        TextField(
          keyboardType: TextInputType.number,
        ),
        IconButton(
          onPressed: onPressed, 
          icon: const Icon(Icons.arrow_right),
        )
      ],
    );
  }
}