import 'package:flutter/material.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/components/home_card.dart';
import 'package:mojipanda/models/home_card_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
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
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          HomeCard(
            model: HomeCardModel(
                IntlUtil.getString(context, Ids.homeCardBlogTitle),
                IntlUtil.getString(context, Ids.homeCardBlogContent),
                "https://mojipanda.com",
                IntlUtil.getString(context, Ids.homeCardBloglabel),
                Constant.jumpTypeWeb),
          ),
        ],
      ),
    );
  }
}
