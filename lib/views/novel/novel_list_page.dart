import 'package:flutter/material.dart';
import 'package:mojipanda/common/resource_mananger.dart';
import 'package:mojipanda/common/router_manager.dart';

import 'package:mojipanda/models/novel_model.dart';
import 'package:mojipanda/widgets/banner_image.dart';

class NovelListPage extends StatefulWidget {
  @override
  _NovelListPageState createState() => _NovelListPageState();
}

class _NovelListPageState extends State<NovelListPage> {
  List<Novel> novels = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    List<Novel> novels = [];
    Novel n1 = Novel(id: '1', name: '测试');
    Novel n2 = Novel(id: '2', name: '测试2');
    novels.add(n1);
    novels.add(n2);
    setState(() {
      this.novels = novels;
    });
  }

  Widget buildItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            child: BannerImage(
              ImageHelper.randomUrl(
                width: 92,
                height: 121,
                key: '123',
              ),
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RouteName.novelDetail, arguments: "1");
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 96,
          child: Text(
            novels[index].name,
            maxLines: 2,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 96,
          child: Text(
            '未读',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('小说'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 20),
                      padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
                      decoration: BoxDecoration(
                          color: Color(0XFFEBF9F6),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Text(
                        "【看书】全网小说不限时免费观看",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    GridView.builder(
                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: novels.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        return buildItem(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
