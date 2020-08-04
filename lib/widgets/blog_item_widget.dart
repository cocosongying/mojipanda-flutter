import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mojipanda/common/router_manager.dart';
import 'package:mojipanda/models/blog_model.dart';
import 'package:mojipanda/widgets/wrapper_image_widget.dart';

class BlogItemWidget extends StatelessWidget {
  final Blog blog;
  final int index;
  final GestureTapCallback onTap;
  final bool top;

  BlogItemWidget(this.blog, {this.index, this.onTap, this.top: false})
      : super(key: ValueKey(blog.id));

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Stack(
      children: <Widget>[
        Material(
          color: top
              ? Theme.of(context).accentColor.withAlpha(10)
              : backgroundColor,
          child: InkWell(
            onTap: onTap ??
                () {
                  Navigator.of(context)
                      .pushNamed(RouteName.blogDetail, arguments: blog);
                },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                bottom: Divider.createBorderSide(context, width: 0.7),
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: WrapperImage(
                          imageType: ImageType.random,
                          url: blog.author,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          blog.author ?? '',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Text(blog.niceDate,
                          style: Theme.of(context).textTheme.caption),
                    ],
                  ),
                  if (blog.envelopePic.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: BlogTitleWidget(blog.title),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              BlogTitleWidget(blog.title),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                blog.desc,
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        WrapperImage(
                          url: blog.envelopePic,
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BlogTitleWidget extends StatelessWidget {
  final String title;

  BlogTitleWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Html(
      // padding: EdgeInsets.symmetric(vertical: 5),
      // useRichText: false,
      data: title,
      // defaultTextStyle: Theme.of(context).textTheme.headline3,
    );
  }
}
