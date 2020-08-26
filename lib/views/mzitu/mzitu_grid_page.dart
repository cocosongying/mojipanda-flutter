import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mojipanda/views/mzitu/mzitu_card_widget.dart';

class MzituGridPage extends StatefulWidget {
  final int id;
  MzituGridPage(this.id);

  @override
  _MzituGridPageState createState() => _MzituGridPageState();
}

class _MzituGridPageState extends State<MzituGridPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = ScrollController();
  int _page = 0;
  int _size = 10;
  var posts = [];

  @override
  void initState() {
    super.initState();
    var c1 = {
      'img': 'https://cdn.jsdelivr.net/gh/zmzt/t2019/09/205045_450.jpg',
      'title': '性感美女阿朱妩媚眼神充满女人味'
    };
    var c2 = {
      'img': 'https://cdn.jsdelivr.net/gh/zmzt/t2020/03/226009_450.jpg',
      'title': '下半身全是腿 国产台湾美女白花花的大腿真是极品'
    };
    posts.add(c1);
    posts.add(c2);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('我监听到底部了!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            itemCount: posts.length,
            primary: false,
            crossAxisCount: 4,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            itemBuilder: (context, index) => MzituCard(
                  img: '${posts[index]['img']}',
                  title: '${posts[index]['title']}',
                ),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
        onRefresh: _refreshData);
  }

  Future _refreshData() async {
    _page = 0;
  }
}
