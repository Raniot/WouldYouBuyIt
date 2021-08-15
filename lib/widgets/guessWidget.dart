import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Guess extends StatelessWidget {
  final Function(int) onPressed;
  final guessController = TextEditingController();

  Guess({
    required this.onPressed
  }
  );
  
  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          child: TextField(
            textInputAction: TextInputAction.go,
            controller: guessController,
            decoration: const InputDecoration(
              hintText: '850,000 kr.',
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              labelText: 'Guess the price'
            ),
            // keyboardType: TextInputType.number, Something is wrong with this shit!!!
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (text) {
              if(text == '') return;
              final formatted = NumberFormat('###,###').format(int.parse(text.replaceAll(',', '')));
              guessController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length)
              );
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(20))
          ),
          child: IconButton(
          onPressed: () => onPressed(int.parse(guessController.text.replaceAll(',', ''))), 
          icon: const Icon(Icons.arrow_right_alt),
          color: Colors.white,
        ),
        )
      ],
    );
  }
}