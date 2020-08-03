import 'package:mojipanda/models/article_model.dart';
import 'package:mojipanda/models/tree_model.dart';
import 'package:mojipanda/provider/view_state_list_model.dart';
import 'package:mojipanda/provider/view_state_refresh_list_model.dart';
import 'package:mojipanda/utils/data_util.dart';

class BlogCategoryViewModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await DataUtil.getBlogCategories();
  }
}

class BlogListViewModel extends ViewStateRefreshListModel<Article> {
  final int cid;
  BlogListViewModel(this.cid);

  @override
  Future<List<Article>> loadData({int pageNum}) async {
    Map<String, dynamic> params = {
      'pageNum': pageNum,
      'cid': cid,
    };
    print(params);
    return await DataUtil.getBlogList(params);
  }

  @override
  onCompleted(List data) {
    //
  }
}
