import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/mzitu_model.dart';
import 'package:mojipanda/utils/url_util.dart';

class MzituCard extends StatelessWidget {
  final Mzitu mzitu;
  MzituCard({this.mzitu});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (mzitu.type < 5) {
          Navigator.of(context)
              .pushNamed(RouteName.mzituPhoto, arguments: mzitu);
        } else {
          Navigator.of(context)
              .pushNamed(RouteName.mzituSingle, arguments: mzitu);
        }
      },
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.deepOrange,
                child:
                    CachedNetworkImage(imageUrl: UrlUtil.getImgUrl(mzitu.url)),
              ),
              mzitu.title != ''
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        '${mzitu.title}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Container(),
            ]),
      ),
    );
  }
}
