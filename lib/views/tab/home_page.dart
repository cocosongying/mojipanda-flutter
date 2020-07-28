import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mojipanda/common/resource_mananger.dart';
import 'package:mojipanda/widgets/banner_image.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:mojipanda/common/common.dart';
import 'package:mojipanda/components/home_card.dart';
import 'package:mojipanda/models/home_card_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  _HomePageState() : super();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bannerHeight = MediaQuery.of(context).size.width * 5 / 11;
    return new Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.zero,
      //   child: AppBar(),
      // ),
      appBar: AppBar(
        title: Text(
          '磨叽熊猫',
          style: TextStyle(fontSize: 16),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_center_focus),
            onPressed: () {
              scan();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(),
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: BannerWidget(),
              centerTitle: true,
            ),
            expandedHeight: bannerHeight,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HomeCard(
                  model: HomeCardModel('博客', 'dd', "https://mojipanda.com",
                      '磨叽熊猫', Constant.jumpTypeWeb),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        child: Icon(Icons.menu),
        overlayColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
        overlayOpacity: 0.5,
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(
              child: Icon(Icons.alarm),
              backgroundColor: Colors.red,
              onTap: () {
                showToast('Button 1');
              }),
          SpeedDialChild(
              child: Icon(Icons.photo),
              backgroundColor: Colors.orange,
              onTap: () {
                showToast('Button 2');
              }),
          SpeedDialChild(
              child: Icon(Icons.videocam),
              backgroundColor: Colors.green,
              onTap: () {
                showToast('Button 3');
              }),
        ],
      ),
    );
  }

  Future scan() async {
    try {
      String result = await scanner.scan();
      showToast(result);
      print(result);
    } catch (e) {
      if (e == scanner.CameraAccessDenied) {
        showToast('没有拍照权限!');
        print('没有拍照权限!');
      } else {
        print(e);
      }
    }
  }
}

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Swiper(
        loop: true,
        autoplay: true,
        autoplayDelay: 5000,
        pagination: SwiperPagination(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: BannerImage(
              ImageHelper.randomUrl(
                width: 300,
                height: 80,
                key: 'cocosongying$index',
              ),
            ),
          );
        },
      ),
    );
  }
}
