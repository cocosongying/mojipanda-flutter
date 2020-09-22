import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mojipanda/common/resource_mananger.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/novel_model.dart';
import 'package:mojipanda/widgets/banner_image.dart';

class NovelDetailPage extends StatefulWidget {
  final String novelId;
  NovelDetailPage(this.novelId);
  @override
  _NovelDetailPageState createState() => _NovelDetailPageState();
}

class _NovelDetailPageState extends State<NovelDetailPage> {
  Novel novel;

  Widget buildTags() {
    var colors = [Color(0xFFF9A19F), Color(0xFF59DDB9), Color(0xFF7EB3E7)];
    var i = 0;
    List<String> tags = [];
    tags.add('one');
    tags.add('two');
    tags.add('three');
    var tagWidgets = tags.map((tag) {
      var color = colors[i % 3];
      var tagWidget = Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(99, color.red, color.green, color.blue),
              width: 0.5),
          borderRadius: BorderRadius.circular(3),
        ),
        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
        child: Text(tag, style: TextStyle(fontSize: 14, color: colors[i % 3])),
      );
      i++;
      return tagWidget;
    }).toList();
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Wrap(runSpacing: 10, spacing: 10, children: tagWidgets),
    );
  }

  Widget buildCover() {
    return Container(
      // color: Theme.of(context).primaryColor.withAlpha(200),
      padding: EdgeInsets.fromLTRB(15, 68, 15, 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BannerImage(
            ImageHelper.randomUrl(
              width: 100,
              height: 137,
              key: '123',
            ),
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text(
                      "标题",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text("作者"),
                  ),
                  buildTags(),
                ]),
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: <Widget>[
        buildCover(),
        Container(
          height: 14,
          color: Theme.of(context).dividerColor,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Text(
              '简介达萨达大师的都是大神大厦将颠看就啊就的卡和的和看车湖和的无ifhiqfhehrfqewfiqehfijqeifhf'),
        ),
        Container(
          height: 14,
          color: Theme.of(context).dividerColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '标题',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            buildContent(),
            Positioned(
              left: 30,
              right: 30,
              bottom: 8,
              child: CupertinoButton(
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(RouteName.novelReader);
                },
                child: Text("阅读", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
