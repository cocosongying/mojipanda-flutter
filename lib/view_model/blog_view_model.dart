import 'package:mojipanda/models/article_model.dart';
import 'package:mojipanda/models/tree_model.dart';
import 'package:mojipanda/provider/view_state_list_model.dart';
import 'package:mojipanda/provider/view_state_refresh_list_model.dart';
import 'package:mojipanda/utils/data_util.dart';

class BlogCategoryModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    return await DataUtil.getBlogCategories();
  }
}

class BlogListModel extends ViewStateRefreshListModel<Article> {
  @override
  Future<List<Article>> loadData({int pageNum}) async {
    return [];
  }

  @override
  onCompleted(List data) {
    //
  }
}
