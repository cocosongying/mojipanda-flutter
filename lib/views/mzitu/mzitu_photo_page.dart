import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MzituPhotoPage extends StatefulWidget {
  final int id;
  MzituPhotoPage({this.id});

  @override
  _MzituPhotoPageState createState() => _MzituPhotoPageState();
}

class _MzituPhotoPageState extends State<MzituPhotoPage> {
  int currentIndex = 0;
  List images = [];
  PageController controller;
  @override
  void initState() {
    images = [
      'https://mojipanda.com/public/download/mzitu/28b01.jpg',
      'https://mojipanda.com/public/download/mzitu/28b56.jpg',
      'https://mojipanda.com/public/download/mzitu/28b02.jpg'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    backgroundDecoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    pageController: controller,
                    // enableRotation: true,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: images.length,
                    gaplessPlayback: false,
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
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(images[index]));
                    }),
              )),
          Positioned(
              top: MediaQuery.of(context).padding.top + 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text("${currentIndex + 1}/${images.length}",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              )),
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
                  })),
        ],
      ),
    );
  }
}
