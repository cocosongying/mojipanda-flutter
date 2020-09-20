import 'dart:async';
import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/widgets/chat/chat_bottom.dart';
import 'package:mojipanda/widgets/chat/expanded_viewport.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final ScrollController listScrollController = new ScrollController();
  final changeNotifier = StreamController.broadcast();
  // AudioPlayer mAudioPlayer = AudioPlayer();
  bool isPalyingAudio = false;
  String mPalyingPosition = "";
  bool isShowLoading = false;
  bool isBottomLayoutShowing = false;

  @override
  void initState() {
    listScrollController.addListener(() {
      if (listScrollController.position.pixels ==
          listScrollController.position.maxScrollExtent) {
        isShowLoading = true;
        setState(() {});
        Future.delayed(Duration(seconds: 2), () {
          isShowLoading = false;
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    changeNotifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '用户名',
          style: TextStyle(fontSize: 16),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15),
            child: InkWell(
              child: Center(
                child: Icon(Icons.more_horiz),
              ),
              onTap: () {
                //
              },
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  changeNotifier.sink.add(null);
                },
                child: ScrollConfiguration(
                  behavior: CustomChatBehavivor(),
                  child: Scrollable(
                    physics: AlwaysScrollableScrollPhysics(),
                    // controller: ,
                    axisDirection: AxisDirection.up,
                    viewportBuilder: (context, offset) {
                      return Container();
                      // return ExpandedViewport(
                      //   offset: offset,
                      //   axisDirection: AxisDirection.up,
                      //   slivers: <Widget>[
                      //     SliverExpanded(),
                      //     // TODO
                      //   ],
                      // );
                    },
                  ),
                ),
              ),
            ),
            ChatBottomInputWidget(
              shouldTriggerChange: changeNotifier.stream,
              onSendCallBack: (value) {
                print("发送的文字:" + value);
                // TODO
              },
            ),
          ],
        ),
      ),
    );
  }
  //
}

class CustomChatBehavivor extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) {
      return child;
    }
    return super.buildViewportChrome(context, child, axisDirection);
  }
}
