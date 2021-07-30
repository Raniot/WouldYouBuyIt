import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatelessWidget {
  final List<String> imageUrls;
  final PageController pageController;
  final Function(int index, PageController controller)? onTapFunc;

  ImageView({
    required this.imageUrls,
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
          itemCount: imageUrls.length,
          pageController: pageController,
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(imageUrls[index]),
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