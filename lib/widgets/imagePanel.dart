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
        pageController: PageController(initialPage: 0),
        onTapFunc: (index, controller) async {
          await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) {
                return ImageView(
                  images: images,
                  pageController: PageController(initialPage: index),
                  onTapFunc: (index, controller2) {
                    Navigator.pop(context);
                    controller.jumpToPage(index);
                  },
                );
              }
            )
          );
        },
      )
    );
  }
}
