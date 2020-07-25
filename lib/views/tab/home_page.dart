import 'package:flutter/material.dart';
import 'package:mojipanda/common/common.dart';
import 'package:mojipanda/components/home_card.dart';
import 'package:mojipanda/models/home_card_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  _HomePageState() : super();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.zero,
      //   child: AppBar(),
      // ),
      appBar: AppBar(
        title: Text(
          '磨叽熊猫',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_center_focus),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          HomeCard(
            model: HomeCardModel('博客', 'dd', "https://mojipanda.com", '磨叽熊猫',
                Constant.jumpTypeWeb),
          ),
        ],
      ),
    );
  }
}
