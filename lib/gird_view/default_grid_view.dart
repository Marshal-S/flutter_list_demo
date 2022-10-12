import 'package:flutter/material.dart';
import 'package:flutter_list_demo/adapt.dart';

class DefaultGridView extends StatelessWidget {
  const DefaultGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ListView需要默认高度，当内容超过ListView设置高度时，即可滚动，否则不能滚动
    return GridView(
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
      //固定列数，取决于crossAxisCount
      //用的比较多，就像UICollectionView一样，就以它为例
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //横轴有几个
        mainAxisSpacing: 10, //主轴方向间距
        crossAxisSpacing: 10, //次轴方向间距
        childAspectRatio: 1, //单个网格宽长比，默认为1，如果是长方形必填
      ),
      //最大列宽，根据间距和最大列宽是否填充满当前行而分成多列，以最少列满足占满横轴为依据
      //使用最大列宽计算，略大于当前屏幕，会缩小列宽为正好满足合适宽度
      //如果等于就使用当前列宽
      //如果刚好小于最大列宽，则会再新增一列，缩小列宽占满横屏
      //以上逻辑不会出现单个列宽小于等于最大列宽，以牺牲部分列宽来满足填充全屏
      //用的比较少
      // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      //   maxCrossAxisExtent: 120,
      //   mainAxisSpacing: 10, //主轴方向间距
      //   crossAxisSpacing: 10, //次轴方向间距
      // ),
      //用到这种情况是，内部不会复用，会以上面的形式来一行一行铺上
      children: [0, 1, 3, 4, 5, 6, 7, 8, 9, 10].map((e) {
        return Container(
          color: Colors.green,
        );
      }).toList(),
    );
  }
}
