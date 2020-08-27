import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MzituPhotoPage extends StatefulWidget {
  List images = [];
  int index = 0;
  PageController controller;
  @override
  _MzituPhotoPageState createState() => _MzituPhotoPageState();
}

class _MzituPhotoPageState extends State<MzituPhotoPage> {
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.index;
    widget.images = [
      'https://imgpc.iimzt.com/2019/09/28b01.jpg',
      'https://imgpc.iimzt.com/2019/09/28b56.jpg',
      'https://imgpc.iimzt.com/2019/09/28b02.jpg'
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
                    backgroundDecoration: null,
                    pageController: widget.controller,
                    enableRotation: true,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: widget.images.length,
                    builder: (BuildContext context, int index) {
                      return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(widget.images[index]));
                    }),
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
