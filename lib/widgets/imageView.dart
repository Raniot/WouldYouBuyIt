import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:would_you_buy_it/models/imageData.dart';

class ImageView extends StatelessWidget {
  final List<ImageData> images;
  final PageController pageController;
  final Function(int index, PageController controller)? onTapFunc;

  ImageView({
    required this.images,
    required this.pageController,
    this.onTapFunc,
  });

  void changeToPage(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoViewGallery.builder(
          itemCount: images.length,
          pageController: pageController,
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(images[index].largeImageUrl),
              initialScale: PhotoViewComputedScale.contained,
              onTapUp: (context, details, value) => onTapFunc?.call(index, pageController)
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