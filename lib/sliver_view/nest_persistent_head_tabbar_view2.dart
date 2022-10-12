import 'dart:ffi';

import 'package:flutter/material.dart';

//类似于淘宝的吸顶效果的tabbar详情页，如果想背景缩放，那么expandHeight高度和图片高度不一致即可
//可以看到，如果想和view1一样的效果，只需要定制的时候下面多放置一个TabbarView即可，Tabcontroller传递进去就好了
class NestPersistentHeaderTabbarView2 extends StatefulWidget {
  const NestPersistentHeaderTabbarView2({Key? key}) : super(key: key);

  @override
  State<NestPersistentHeaderTabbarView2> createState() => _NestPersistentHeaderViewState();
}

class _NestPersistentHeaderViewState extends State<NestPersistentHeaderTabbarView2> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final List<String> tabs = ["宝贝", "评价", "详情", "推荐"];

  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverPersistentHeader(
              pinned: true, //
              delegate: StickyTabbarDelegate(
                background: Image.asset("images/six_wings_angle_gril.png", fit: BoxFit.cover,),
                padding: MediaQuery.of(context).padding.top,
                collapsedHeight: 88,
                expandHeight: 300, //如果不想内部缩放，高度和background一样即可
                controller: _controller,
                tabNames: tabs,
                title: "六翼天使",
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: tabs.map<Widget>((e) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10), //设置padding，避免默认的Padding
              itemExtent: 200,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GridView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map<Widget>((e) {
                      return Container(
                        color: Colors.greenAccent,
                      );
                    }).toList(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.blue,
                  ),
                );
              },
              itemCount: 20,
            );
          }).toList(),
        ),
      ),
    );
  }
}

//自定义顶部效果(这里类似购物详情)，需要继承自SliverPersistentHeaderDelegate，这样定制起来更简洁
class StickyTabbarDelegate extends SliverPersistentHeaderDelegate {
  final Widget background;
  final double padding;
  final double collapsedHeight; //收缩高度，appbar和tabbar平分高度
  final double expandHeight;
  final Widget? titleView;
  final TabController? controller;
  final List<String> tabNames;

  StickyTabbarDelegate({
    required this.background,
    required this.collapsedHeight,
    required this.expandHeight,
    this.padding = 0,
    this.controller,
    required this.tabNames,
    Widget? titleView,
    String? title,
  })  : assert(titleView == null || title == null, '不能同时传递两个',),
        titleView = titleView ?? Text(title ?? '', style: const TextStyle(color: Colors.black, fontSize: 16,),);

  @override
  double get minExtent => collapsedHeight + padding;

  @override
  double get maxExtent => expandHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: Stack(
        fit: StackFit.expand, //内部铺满
        children: [
          background,
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              color: getBkgColor(shrinkOffset),
              child: SafeArea(
                //取消底部间距
                bottom: false,
                child: Column(
                  children: [
                    SizedBox(
                      height: collapsedHeight / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //这button默认的效果不满意，可以自己使用手势自定义button效果，这里只是写着方便而已
                          MaterialButton(
                            minWidth: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: collapsedHeight / 2.5,
                              height: collapsedHeight / 2.5,
                              decoration: BoxDecoration(
                                color: getBtnBkgColor(shrinkOffset),
                                borderRadius: BorderRadius.circular(collapsedHeight / 4),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: getTextColor(shrinkOffset),
                                size: collapsedHeight / 4,
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: getOpacity(shrinkOffset),
                            child: titleView!,
                          ),
                          MaterialButton(
                            minWidth: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            onPressed: () {
                              print("点击了分享");
                            },
                            child: Container(
                              width: collapsedHeight / 2.5,
                              height: collapsedHeight / 2.5,
                              decoration: BoxDecoration(
                                color: getBtnBkgColor(shrinkOffset),
                                borderRadius: BorderRadius.circular(collapsedHeight / 4),
                              ),
                              child: Icon(
                                Icons.share,
                                color: getTextColor(shrinkOffset),
                                size: collapsedHeight / 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: getOpacity(shrinkOffset),
                      child: SizedBox(
                        height: collapsedHeight / 2,
                        child: TabBar(
                          labelColor: Colors.black,
                          controller: controller,
                          tabs: tabNames.map((e) => Tab(text: e,)).toList(),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getOpacity(double shrinkOffset) {
    return (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
  }

  Color getBkgColor(double shrinkOffset) {
    final double opacity = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    return Color.fromRGBO(0xff, 0xff, 0xff, opacity);
  }

  Color getBtnBkgColor(double shrinkOffset) {
    final double opacity = (shrinkOffset / (maxExtent - minExtent) * 2).clamp(0, 1);
    return Color.fromRGBO(0x33, 0x33, 0x33, 1 - opacity);
  }

  Color getTextColor(double shrinkOffset) {
    final double opacity = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    if (opacity <= 0.25) {
      return Color.fromRGBO(0xff, 0xff, 0xff, 1 - opacity);
    }else {
      return Color.fromRGBO(0, 0, 0, opacity);
    }
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    //是否支持重新构建，如果为false，即使外部更新属性，组件也不会被重新构建，根据需要设置即可
    return true;
  }
}