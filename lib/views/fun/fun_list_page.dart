import 'package:flutter/material.dart';
import 'package:mojipanda/common/resource_mananger.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/web_model.dart';
import 'package:mojipanda/widgets/banner_image.dart';

class FunListPage extends StatefulWidget {
  @override
  _FunListPageState createState() => _FunListPageState();
}

class _FunListPageState extends State<FunListPage> {
  List<String> funs = ['魔方', 'b'];
  List<String> funUrls = [
    'https://mojipanda.com/play/cube3v.html',
    'https://mojipanda.com/fun/'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('娱乐'),
      ),
      body: initFunList(funs),
    );
  }

  Widget initFunList(List<String> funs) {
    double width = (MediaQuery.of(context).size.width - 20) / 3;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.6,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (_, index) {
        return Material(
          color: Colors.white,
          child: InkWell(
            child: Column(children: <Widget>[
              BannerImage(
                ImageHelper.randomUrl(
                  width: width.toInt(),
                  height: width * 57 ~/ 43,
                  key: 'fun$index',
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(funs[index],
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ], crossAxisAlignment: CrossAxisAlignment.start),
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.web,
                  arguments: WebModel()
                    ..title = funs[index]
                    ..url = funUrls[index]);
            },
          ),
        );
      },
      itemCount: funs.length,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
