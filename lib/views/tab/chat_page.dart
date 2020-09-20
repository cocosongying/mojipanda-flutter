import 'package:flutter/material.dart';
import 'package:mojipanda/common/router_manager.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    list.add(buildChatItem('', '系统', '你好啊', '刚刚', isBadge: true));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "消息",
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          PopupMenuButton(
            offset: Offset(0, 70),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<int>>[
                PopupMenuItem(
                  child: Text("菜单1"),
                  value: 0,
                ),
              ];
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(child: ListView(children: list))),
        ],
      ),
    );
  }

  Widget buildChatItem(String imgUrl, String name, String lastMsg, String time,
      {bool isBadge = false}) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: () {
            // TODO CHAT
            Navigator.of(context).pushNamed(RouteName.chatDetail);
          },
          leading: Container(
            height: 43,
            width: 43,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      "https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658",
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                isBadge == true
                    ? Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.fromBorderSide(BorderSide(
                                  width: 1, color: Colors.red[600]))),
                          child: Container(
                            color: Colors.red[600],
                            height: 6,
                            width: 6,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          title: Container(
              child: Text(
            name,
            style: TextStyle(fontSize: 15),
            maxLines: 1,
          )),
          subtitle: Container(
            child: Text(
              lastMsg,
              style: TextStyle(color: Colors.grey, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Container(
            child: Text(
              time,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey[400],
          indent: 70,
        )
      ],
    );
  }
}
