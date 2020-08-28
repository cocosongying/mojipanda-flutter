import 'package:mojipanda/models/tree_model.dart';
import 'package:mojipanda/provider/view_state_list_model.dart';

class MzituCategoryViewModel extends ViewStateListModel<Tree> {
  @override
  Future<List<Tree>> loadData() async {
    Tree t0 = Tree(1, '首页', 0, 1);
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
