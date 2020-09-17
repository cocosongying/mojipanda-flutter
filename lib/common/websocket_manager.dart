import 'dart:convert';

import 'package:mojipanda/api/api.dart';
import 'package:mojipanda/common/storage_manager.dart';
import 'package:mojipanda/event/event_bus.dart';
import 'package:mojipanda/event/event_model.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketManager {
  static IOWebSocketChannel channel;
  WebSocketManager.create() {
    var token = StorageManager.sharedPreferences.get('kToken') ?? '';
    channel = IOWebSocketChannel.connect(Api.WEBSOCKET_URL + "?token=$token");
    channel.stream.listen((message) {
      print(message);
      try {
        var data = json.decode(message);
        var type = data[0];
        switch (type) {
          case 1:
            ApplicationEvent.event.fire(MsgEvent("收到" + message));
            break;
          default:
            ApplicationEvent.event.fire(HelloEvent("收到" + message));
        }
      } catch (e) {}
    });
  }

  WebSocketManager.sendMessage(data) {
    channel.sink.add(data);
  }
}
