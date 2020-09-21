import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojipanda/common/common.dart';

class NovelReaderPage extends StatefulWidget {
  @override
  _NovelReaderPageState createState() => _NovelReaderPageState();
}

class _NovelReaderPageState extends State<NovelReaderPage> with RouteAware {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didPop() {
    // TODO: implement didPop
    super.didPop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Image.asset(Constant.ASSETS_IMG + "read_bg.png"),
            ),
          ],
        ),
      ),
    );
  }
}
