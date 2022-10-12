import 'package:flutter/material.dart';
import 'package:flutter_list_demo/adapt.dart';

class DefaultListView extends StatelessWidget {
  const DefaultListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ListView需要默认高度，当内容超过ListView设置高度时，即可滚动，否则不能滚动
    return ListView(
      //该属性默认为false，设置为false表示内部滚动方向无穷长，不会完全计算全部内容长度
      //如果该属性设置为true，会尽可能缩放滚动视图，一次性计算出所有内容，然后布局
      //一般嵌套滚动视图时设置为true，或者根据情况使用，一般不推荐，长列表过多计算可能会造成卡顿
      shrinkWrap: false,
      //默认是垂直方向滑动，也可以竖直方向滑动，可以详细查看其它属性
      scrollDirection: Axis.vertical,
      //设置padding
      padding: const EdgeInsets.all(0),
      //设置滚动效果，这是比较常用的几个参数了
      //都和ios一样任何情况都支持回弹，不填默认ios回弹，android水波纹
      physics: const AlwaysScrollableScrollPhysics(
        //两端都拥有弹性效果，不填这里和默认physics不写一样
        parent: BouncingScrollPhysics(),
      ),
      //回弹效果,但不满屏不能滑动
      // physics: const BouncingScrollPhysics(),
      children: [
        const CardView(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            color: Colors.green,
            height: 300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            color: Colors.blue,
            height: 400,
          ),
        ),
      ],
    );
  }
}

//使用时建议多拆分组件
class CardView extends StatelessWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        color: Colors.grey,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 180,
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "标题",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "我是内容",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

