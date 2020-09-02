import 'package:mojipanda/models/mzitu_model.dart';
import 'package:mojipanda/models/tree_model.dart';
import 'package:mojipanda/provider/view_state_list_model.dart';
import 'package:mojipanda/provider/view_state_refresh_list_model.dart';
import 'package:mojipanda/utils/data_util.dart';

class MzituCategoryViewModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    Tree t0 = Tree(0, '首页', 0, 1);
    Tree t1 = Tree(1, '性感妹子', 1, 1);
    Tree t2 = Tree(2, '日本妹子', 2, 1);
    Tree t3 = Tree(3, '台湾妹子', 3, 1);
    Tree t4 = Tree(4, '清纯妹子', 4, 1);
    Tree t5 = Tree(5, '妹子自拍', 5, 1);
    Tree t6 = Tree(6, '街拍美女', 6, 1);
    List<Tree> list = [t0, t1, t2, t3, t4, t5, t6];
    return list;
  }
}

class MzituListViewModel extends ViewStateRefreshListModel<Mzitu> {
  final int type;
  MzituListViewModel(this.type);

  @override
  Future<List<Mzitu>> loadData({int pageNum}) async {
    Map<String, dynamic> params = {
      'type': type,
      'start': pageNum,
    };
    return await DataUtil.getMzituList(params);
  }

  @override
  onCompleted(List data) {
    //
  }
}

class MzituDetailViewModel extends ViewStateListModel<Mzitu> {
  @override
  Future<List<Mzitu>> loadData({int id}) async {
    Map<String, dynamic> params = {
      'id': id,
    };
    return await DataUtil.getMzituGrid(params);
  }
}
