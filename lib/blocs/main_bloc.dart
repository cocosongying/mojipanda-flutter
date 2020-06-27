// import 'dart:collection';
import 'package:mojipanda/common/component_index.dart';

class MainBloc implements BlocBase {
  @override
  void dispose() {}

  @override
  Future getData({String labelId, int page}) {
    return Future.delayed(new Duration(seconds: 1));
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(labelId: labelId, page: 0);
  }
}
