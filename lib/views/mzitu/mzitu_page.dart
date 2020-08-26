import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mojipanda/models/tree_model.dart';
import 'package:mojipanda/provider/provider_widget.dart';
import 'package:mojipanda/provider/view_state_widget.dart';
import 'package:mojipanda/utils/status_bar_util.dart';
import 'package:mojipanda/view_model/mzitu_view_model.dart';
import 'package:mojipanda/views/mzitu/mzitu_grid_page.dart';
import 'package:mojipanda/views/tab/blog_page.dart';
import 'package:provider/provider.dart';

class MzituPage extends StatefulWidget {
  @override
  _MzituPageState createState() => _MzituPageState();
}

class _MzituPageState extends State<MzituPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  ValueNotifier<int> valueNotifier;
  TabController tabController;

  @override
  void initState() {
    valueNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: StatusBarUtil.systemUiOverlayStyle(context),
      child: ProviderWidget<MzituCategoryViewModel>(
        model: MzituCategoryViewModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (context, model, child) {
          if (model.isBusy) {
            return ViewStateBusyWidget();
          }
          if (model.isError) {
            return ViewStateErrorWidget(
                error: model.viewStateError, onPressed: model.initData);
          }
          List<Tree> treeList = model.list;
          var primaryColor = Theme.of(context).primaryColor;
          return ValueListenableProvider<int>.value(
            value: valueNotifier,
            child: DefaultTabController(
              length: model.list.length,
              initialIndex: valueNotifier.value,
              child: Builder(builder: (context) {
                if (tabController == null) {
                  tabController = DefaultTabController.of(context);
                  tabController.addListener(() {
                    valueNotifier.value = tabController.index;
                  });
                }
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    title: Stack(
                      children: [
                        CategoryDropdownWidget(
                            Provider.of<MzituCategoryViewModel>(context)),
                        Container(
                          margin: const EdgeInsets.only(right: 25),
                          color: primaryColor.withOpacity(1),
                          child: TabBar(
                              isScrollable: true,
                              tabs: List.generate(
                                  treeList.length,
                                  (index) => Tab(
                                        text: treeList[index].name,
                                      ))),
                        )
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: List.generate(treeList.length,
                        (index) => MzituGridPage(treeList[index].id)),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
