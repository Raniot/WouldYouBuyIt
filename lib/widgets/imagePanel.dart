import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:would_you_buy_it/models/imageData.dart';
import 'package:would_you_buy_it/widgets/imageView.dart';

class ImagePanel extends StatelessWidget {
  final List<ImageData> images;
  final double height;
  final double width;

  ImagePanel({
    required this.images,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.all(5),
      child: SizedBox(
        height: this.height,
        width: this.width,
        child: ImageView(
          imageUrls: images.map((imageData) => imageData.lowResTabletImageUrl).toList(),
          pageController: PageController(initialPage: 0),
          onTapFunc: (index, controller) async {
            await Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) {
                  return ImageView(
                    imageUrls: images.map((imageData) => imageData.largeImageUrl).toList(),
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
      ),
    );
  }
}
