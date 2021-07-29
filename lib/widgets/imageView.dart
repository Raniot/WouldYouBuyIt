import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:would_you_buy_it/models/imageData.dart';

class ImageView extends StatelessWidget {
  final List<ImageData> images;
  final int startingIndex;
  final Function(int? index)? onTapFunc;

  ImageView({
    required this.images,
    required this.startingIndex,
    this.onTapFunc
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoViewGallery.builder(
          itemCount: images.length,
          pageController: PageController(initialPage: startingIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(images[index].largeImageUrl),
              initialScale: PhotoViewComputedScale.contained,
              onTapUp: (context, details, value) => onTapFunc?.call(index)
            );
          },
          loadingBuilder: (context, event) => Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          ),
          backgroundDecoration: BoxDecoration(
            color: Colors.transparent
          ),
        ),
    );
  }
}