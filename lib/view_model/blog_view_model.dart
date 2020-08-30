import 'package:mojipanda/models/blog_model.dart';
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

class BlogListViewModel extends ViewStateRefreshListModel<Blog> {
  final int cid;
  BlogListViewModel(this.cid);

  @override
  Future<List<Blog>> loadData({int pageNum}) async {
    Map<String, dynamic> params = {
      'pageNum': pageNum,
      'cid': cid,
    };
    return await DataUtil.getBlogList(params);
  }

  @override
  onCompleted(List data) {
    //
  }
}
