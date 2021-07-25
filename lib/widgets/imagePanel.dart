import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:would_you_buy_it/models/house.dart';

class ImagePanel extends StatelessWidget {
  final House house;
  ImagePanel({
    required this.house
  });

  @override
  Widget build(BuildContext context){
    var images = house.imageData;

    return SizedBox(
      height: 250,
      width: 300,
      child: PhotoViewGallery.builder(
        itemCount: images.length, 
        pageController: PageController(initialPage: 0),
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index].thumbnailUrl),
            initialScale: PhotoViewComputedScale.contained,
            onTapUp: (context, details, value) {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return Container(
                      child: PhotoViewGallery.builder(
                          itemCount: images.length,
                          pageController: PageController(initialPage: index),
                          scrollPhysics: const BouncingScrollPhysics(),
                          builder: (context, index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: NetworkImage(images[index].largeImageUrl),
                              initialScale: PhotoViewComputedScale.contained,
                              onTapUp: (context, details, value) {
                                Navigator.pop(context);
                              }
                            );
                          },
                          loadingBuilder: (context, event) => Center(
                            child: Container(
                              child: CircularProgressIndicator(
                                value: event == null
                                  ? 0
                                  : event.cumulativeBytesLoaded / int.parse(event.expectedTotalBytes.toString())
                              ),
                            ),
                          ),
                          backgroundDecoration: BoxDecoration(
                            color: Colors.transparent
                          ),
                        ),
                    );
                  })
              );
            }
          );
        },
        loadingBuilder: (context, event) => Center(
          child: Container(
            child: CircularProgressIndicator(
              value: event == null
                ? 0
                : event.cumulativeBytesLoaded / int.parse(event.expectedTotalBytes.toString())
            ),
          ),
        ),
        backgroundDecoration: BoxDecoration(
          color: Colors.transparent
        ),
      ),
    );
  }
}