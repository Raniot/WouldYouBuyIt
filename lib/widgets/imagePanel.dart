import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:would_you_buy_it/models/house.dart';

class ImagePanel extends StatelessWidget {
  final House house;
  ImagePanel({
    required this.house
  });

  List<Widget> getHouseImages(House house) {
    List<Widget> list = [];
    for(int i = 0; i < house.imageData.length; i++){
      list.add(
        Padding(
          padding: EdgeInsets.all(10),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.network(
              house.imageData[i].thumbnailUrl
            )
          )
        )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: getHouseImages(house),
        )
      )
    );
  }
}