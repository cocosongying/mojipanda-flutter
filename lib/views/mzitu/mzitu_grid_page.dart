import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mojipanda/view_model/mzitu_view_model.dart';
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
  var posts = [];

  @override
  void initState() {
    super.initState();
    _getDate(true);
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
                  url: '${posts[index].url}',
                  title: '${posts[index].title}',
                ),
            staggeredTileBuilder: (index) => StaggeredTile.fit(2)),
        onRefresh: _refreshData);
  }

  Future _refreshData() async {
    _page = 0;
  }

  void _getDate(bool _beAdd) async {
    var result = await MzituListViewModel(widget.id).loadData(pageNum: _page);
    setState(() {
      if (!_beAdd) {
        posts.clear();
        posts = result == null ? [] : result;
      } else {
        posts.addAll(result);
      }
    });
  }
}
