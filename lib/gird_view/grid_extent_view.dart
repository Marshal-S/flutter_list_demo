

//SliverGridDelegateWithFixedCrossAxisCount的语法糖
import 'package:flutter/material.dart';

class GridExtentView extends StatelessWidget {
  const GridExtentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SliverGridDelegateWithFixedCrossAxisCount的语法糖,内部属性被展开
    return GridView.extent(
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
      maxCrossAxisExtent: 120,//设置最大列宽
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      //用到这种情况是，内部不会复用，会以上面的形式来一行一行铺上
      children: [0, 1, 3, 4, 5, 6, 7, 8, 9, 10].map((e) {
        return Container(
          color: Colors.blueAccent,
        );
      }).toList(),
    );
  }
}