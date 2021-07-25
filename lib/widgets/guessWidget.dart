import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Guess extends StatelessWidget {
  final Function() onPressed;

  Guess({
    required this.onPressed
  });
  
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: '850000',
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              labelText: 'Guess the price'
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20))
          ),
          child: IconButton(
          onPressed: onPressed, 
          icon: const Icon(Icons.arrow_right_alt),
          color: Colors.white,
        ),
        )
      ],
    );
  }
}