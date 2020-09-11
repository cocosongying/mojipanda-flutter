import 'package:mojipanda/api/api.dart';
import 'package:mojipanda/event/event_bus.dart';
import 'package:mojipanda/event/event_model.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketManager {

  WebSocketManager._();
  static WebSocketManager _manager;
  IOWebSocketChannel channel;

  factory WebSocketManager() {
    if (_manager == null) {
      _manager = WebSocketManager._();
    }
    return _manager;
  }
  
  void init() {
    channel = IOWebSocketChannel.connect(Api.WEBSOCKET_URL + "?token=abcd1234");
    channel.sink.add('hello');
    channel.stream.listen((data) => listenMessage(data), onError: onError, onDone: onDone);
  }

  void sendMessage(data) {
    channel.sink.add(data);
  }

  void listenMessage(data) {
    print(data);
    ApplicationEvent.event.fire(HelloEvent("收到" + data));
  }

  void onError(error) {
    print(error);
  }

  void onDone() {
    print('websocket断开了');
  }

  void closeWebSocket(){//关闭链接
    channel.sink.close();
    print('关闭了websocket');
  }
}