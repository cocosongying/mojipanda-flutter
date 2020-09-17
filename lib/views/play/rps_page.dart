import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mojipanda/common/websocket_manager.dart';
import 'package:mojipanda/event/event_bus.dart';
import 'package:mojipanda/event/event_model.dart';
import 'package:oktoast/oktoast.dart';

class RPSPage extends StatefulWidget {
  @override
  _RPSPageState createState() => _RPSPageState();
}

class _RPSPageState extends State<RPSPage> {
  StreamSubscription rpsEvent;

  @override
  void initState() {
    super.initState();
    rpsEvent = ApplicationEvent.event.on<HelloEvent>().listen((event) {
      print('rps' + event.msg);
      showToast(event.msg);
    });
    WebSocketManager.sendMessage('[1,[0]]');
  }

  @override
  void dispose() {
    rpsEvent.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
