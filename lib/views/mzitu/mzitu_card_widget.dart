import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class MzituCard extends StatelessWidget {
  final String img;
  final String title;
  MzituCard({this.img, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showToast("点击了");
      },
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.deepOrange,
                child: CachedNetworkImage(imageUrl: '$img'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '$title',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
      ),
    );
  }
}
