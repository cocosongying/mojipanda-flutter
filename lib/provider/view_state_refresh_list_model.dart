import 'package:mojipanda/provider/view_state_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  static const int pageStart = 0;
  static const int pageSize = 20;

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  int _currentPage = pageStart;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<List<T>> loadData({int pageNum});

  Future<List<T>> refresh({bool init = false}) async {
    try {
      _currentPage = pageStart;
      var data = await loadData(pageNum: pageStart);
      if (data.isEmpty) {
        refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        setIdle();
      }
      return data;
    } catch (e, s) {
      if (init) {list.clear();}
      refreshController.refreshFailed();
      setError(e, s);
      return null;
    }
  }

  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPage);
      if (data.isEmpty) {
        _currentPage--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e) {
      _currentPage--;
      refreshController.loadFailed();
      return null;
    }
  }
}