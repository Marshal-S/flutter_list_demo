import 'package:flutter/material.dart';

//一般是个人页或者朋友圈之类的效果,几种顶部效果
const List<String> tabNames = ["floating", "snap", "pinned"];

class SliverAppBarView extends StatefulWidget {
  const SliverAppBarView({Key? key}) : super(key: key);

  @override
  State<SliverAppBarView> createState() => _SliverAppBarViewState();
}

class _SliverAppBarViewState extends State<SliverAppBarView> {
  int status = 0;

  Widget getFloatSliverAppBar() {
    return SliverAppBar(
      //如果不是应用到主控制器，设置false，避免显示返回
      automaticallyImplyLeading: false,
      floating: true,
      //缩小的最小高度,不能低于toolbar的默认高度56（修改小了也不行）
      collapsedHeight: 56,
      //拉伸最大高度
      expandedHeight: 200,
      elevation: 0, //高度和appbar一样设置了有利于规避阴影
      //FlexibleSpaceBar类似于朋友圈背景墙的组件
      //title底部文字，background背景图片、centerTitle中间文字，根据自己需要定制即可
      flexibleSpace: FlexibleSpaceBar(
        title: TextButton(
          onPressed: () {
            status++;
            status %= 3;
            setState(() {});
          },
          child: Text(
            "点击切换Bar，当前类型: ${tabNames[status]}",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        background: Container(
          color: Colors.blue,
          height: 150,
        ),
      ),
      // flexibleSpace: Container(
      //   color: Colors.red,
      // ),
    );
  }

  Widget getSnapSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      floating: true,
      snap: true,
      collapsedHeight: 56,
      expandedHeight: 200,
      elevation: 0,
      //FlexibleSpaceBar类似于朋友圈背景墙的组件
      //title底部文字，background背景图片、centerTitle中间文字，根据自己需要定制即可
      flexibleSpace: FlexibleSpaceBar(
        title: TextButton(
          onPressed: () {
            status++;
            status %= 3;
            setState(() {});
          },
          child: Text(
            "点击切换Bar，当前类型: ${tabNames[status]}",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        background: Container(
          color: Colors.blue,
          height: 150,
        ),
      ),
    );
  }

  Widget getPinndSliverAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      collapsedHeight: 56,
      expandedHeight: 200,
      elevation: 0,
      //FlexibleSpaceBar类似于朋友圈背景墙的组件
      //title底部文字，background背景图片、centerTitle中间文字，根据自己需要定制即可
      flexibleSpace: FlexibleSpaceBar(
        title: TextButton(
          onPressed: () {
            status++;
            status %= 3;
            setState(() {});
          },
          child: Text(
            "点击切换Bar，当前类型: ${tabNames[status]}",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        background: Container(
          color: Colors.blue,
          height: 150,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //切换状态栏
          status == 0
              ? getFloatSliverAppBar()
              : status == 1
                  ? getSnapSliverAppBar()
                  : getPinndSliverAppBar(),

          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final isSingle = index % 2 == 1;
                return Container(
                  alignment: Alignment.center,
                  color: isSingle ? Colors.white : Colors.greenAccent,
                  child: Text(
                    index.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                );
              },
              childCount: 50,
            ),
            itemExtent: 60,
          ),
        ],
      ),
    );
  }
}
