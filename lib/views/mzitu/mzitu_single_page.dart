import 'package:flutter/material.dart';
import 'package:mojipanda/models/mzitu_model.dart';
import 'package:mojipanda/utils/url_util.dart';
import 'package:photo_view/photo_view.dart';

class MzituSinglePage extends StatefulWidget {
  final Mzitu mzitu;
  MzituSinglePage({this.mzitu});

  @override
  _MzituSinglePageState createState() => _MzituSinglePageState();
}

class _MzituSinglePageState extends State<MzituSinglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: PhotoView(
                imageProvider:
                    NetworkImage(UrlUtil.getImgUrl(widget.mzitu.url)),
                loadingBuilder: (context, progress) => Center(
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                        value: progress == null
                            ? null
                            : progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes),
                  ),
                ),
                backgroundDecoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
