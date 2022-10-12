import 'package:flutter/material.dart';

//普通的带吸顶效果的tabbar详情页，如果不想背景缩放，那么expandHeight高度和图片高度一致即可
class NestPersistentHeaderTabbarView1 extends StatefulWidget {
  const NestPersistentHeaderTabbarView1({Key? key}) : super(key: key);

  @override
  State<NestPersistentHeaderTabbarView1> createState() => _NestPersistentHeaderViewState();
}

class _NestPersistentHeaderViewState extends State<NestPersistentHeaderTabbarView1> with SingleTickerProviderStateMixin {
  final List<String> tabNames = ["全部", "采购", "出售"];
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: tabNames.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("六翼天使",
                  style: TextStyle(color: Colors.white, fontSize: 16),),
                background: Image.asset(
                  "images/six_wings_angle_gril.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //默认 persistentheader，使用最小间距即可
            SliverPersistentHeader(
              pinned: true,
              delegate: DefaultStickyTabbarDelegate(
                child: TabBar(
                  controller: _controller,
                  labelColor: Colors.black,
                  tabs: tabNames.map((e) => Tab(text: e,)).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: tabNames.map<Widget>((e) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10), //设置padding，避免默认的Padding
              itemExtent: 200,
              itemBuilder: (context, index) {
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

//主要是利用 SliverPersistentHeaderDelegate 默认顶部效果
class DefaultStickyTabbarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  DefaultStickyTabbarDelegate({
    required this.child,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: child,
    );
  }

  //两个高度一致即可，设置成tabbar的默认高度
  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
