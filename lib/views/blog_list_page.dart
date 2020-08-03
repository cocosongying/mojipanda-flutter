import 'package:flutter/material.dart';
import 'package:mojipanda/models/article_model.dart';
import 'package:mojipanda/provider/provider_widget.dart';
import 'package:mojipanda/provider/view_state_widget.dart';
import 'package:mojipanda/view_model/blog_view_model.dart';
import 'package:mojipanda/widgets/blog_item_widget.dart';
import 'package:mojipanda/widgets/blog_skeleton_widget.dart';
import 'package:mojipanda/widgets/skeleton_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlogListPage extends StatefulWidget {
  final int cid;
  BlogListPage(this.cid);

  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<BlogListViewModel>(
        model: BlogListViewModel(widget.cid),
        onModelReady: (model) => model.initData(),
        builder: (context, model, child) {
          if (model.isBusy) {
            return SkeletonList(
              builder: (context, index) => BlogSkeletonItem(),
            );
          } else if (model.isError && model.list.isEmpty) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          } else if (model.isEmpty) {
            return ViewStateEmptyWidget(onPressed: model.initData);
          }
          return SmartRefresher(
            controller: model.refreshController,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            onRefresh: model.refresh,
            onLoading: model.loadMore,
            enablePullUp: true,
            child: ListView.builder(
                itemCount: model.list.length,
                itemBuilder: (context, index) {
                  Article item = model.list[index];
                  return BlogItemWidget(item);
                }),
          );
        });
  }
}
