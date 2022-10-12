import 'package:flutter/material.dart';
import 'package:flutter_list_demo/sliver_view/sliver_persistent_header.dart';

//和CustomScrollView类似，只不过区分了头和body
//header只能使用Sliver系列，body可以使用日常组件了
//需要注意的是 Sliver 对于有限滚动内容的滑动是连贯的，可以拉伸，一旦出现builder，则拉伸会出现分离现象
//另外，新起一个页面时，受 安全区域影响，滚动视图默认会有一个内部padding，可以通过设置 padding来解除
class NestedScrollNormalView extends StatelessWidget {
  const NestedScrollNormalView({Key? key}) : super(key: key);

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
          ];
        },
        body: ListView.builder(
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
        ),
      ),
    );
  }
}