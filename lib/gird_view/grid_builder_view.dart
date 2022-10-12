

import 'package:flutter/material.dart';

//和 GridView.builder 复用
//相当于 ios 的 UICollectionView
class GridBuildView extends StatelessWidget {
  const GridBuildView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SliverGridDelegateWithFixedCrossAxisCount的语法糖,内部属性被展开
    return GridView.builder(
      //默认是垂直方向滑动，也可以竖直方向滑动，可以详细查看其它属性
      scrollDirection: Axis.vertical,
      //设置padding
      padding: const EdgeInsets.all(10),
      //设置滚动效果，这是比较常用的几个参数了
      //都和ios一样支持回弹，不填默认ios回弹，android水波纹
      physics: const AlwaysScrollableScrollPhysics(
        //两端都拥有弹性效果，不填这里和默认physics不写一样
        parent: BouncingScrollPhysics(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75, //单个网格宽长比，默认为1，如果这里是垂直方向比较高
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}