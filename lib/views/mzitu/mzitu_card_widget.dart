import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/router_manager.dart';

class MzituCard extends StatelessWidget {
  final String url;
  final String title;
  MzituCard({this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(RouteName.mzituPhoto);
      },
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.deepOrange,
                child: CachedNetworkImage(imageUrl: '$url'),
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
