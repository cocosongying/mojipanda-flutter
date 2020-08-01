import 'package:mojipanda/provider/view_state_list_model.dart';
import 'package:mojipanda/provider/view_state_refresh_list_model.dart';

class StructureCategoryViewModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    return [];
  }
}

class StructureListViewModel extends ViewStateRefreshListModel {
  final int cid;
  StructureListViewModel(this.cid);
  @override
  Future<List> loadData({int pageNum}) async {
    return [];
  }

  @override
  onCompleted(List data) {
    //
  }
}

class NavigationSiteModel extends ViewStateListModel {
  @override
  Future<List> loadData() async {
    return [];
  }
}
