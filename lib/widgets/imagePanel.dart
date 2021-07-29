import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/models/imageData.dart';
import 'package:would_you_buy_it/widgets/imageView.dart';

class ImagePanel extends StatelessWidget {
  final List<ImageData> images;
  ImagePanel({
    required this.images
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 250,
      width: 300,
      child: ImageView(
        images: images,
        startingIndex: 0,
        onTapFunc: (index) => {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return ImageView(
                  images: images,
                  startingIndex: index ?? 0,
                  onTapFunc: (index) => Navigator.pop(context),
                );
              }
            )
          )
        },
      )
    );
  }
}