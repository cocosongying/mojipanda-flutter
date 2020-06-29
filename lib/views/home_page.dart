import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/component_index.dart';
import 'package:mojipanda/routers/routers.dart';

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
      appBar: new AppBar(
        title: new Text(IntlUtil.getString(context, Ids.titleHome)),
      ),
      body: new Center(
          child: MaterialButton(
        child: new Text(IntlUtil.getString(context, Ids.titleBlog)),
        onPressed: () {
          FluroRouter.router.navigateTo(
            context,
            '${FluroRouter.webViewPage}?title=${Uri.encodeComponent('磨叽熊猫')}&url=${Uri.encodeComponent('https://mojipanda.com')}',
            transition: TransitionType.nativeModal,
          );
        },
      )),
    );
  }
}
