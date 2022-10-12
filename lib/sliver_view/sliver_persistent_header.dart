import 'package:flutter/material.dart';

//实现类似朋友圈之类的效果，解决下部滑动问题
class SliverPersistentHeaderNormalView extends StatelessWidget {
  const SliverPersistentHeaderNormalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true, //
            delegate: CeilStickyHeadDelegate(
              background: Image.asset("images/six_wings_angle_gril.png", fit: BoxFit.cover,),
              collapsedHeight: 50,
              expandHeight: 300,
              title: "六翼天使",
            ),
          ),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.blue,
                  ),
                );
              },
              childCount: 20,
            ),
            itemExtent: 40,
          ),
        ],
      ),
    );
  }
}

//自定义顶部效果(这里类似朋友圈)，需要继承自SliverPersistentHeaderDelegate，这样定制起来更简洁
class CeilStickyHeadDelegate extends SliverPersistentHeaderDelegate {
  final Widget background;
  final double collapsedHeight;
  final double expandHeight;
  final Widget? titleView;

  CeilStickyHeadDelegate({
    required this.background,
    required this.collapsedHeight,
    required this.expandHeight,
    Widget? titleView,
    String? title,
  }): assert(titleView == null || title == null, '不能同时传递两个',),
      titleView = titleView ?? Text(title ?? '', style: const TextStyle(color: Colors.black, fontSize: 16,),);

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => expandHeight;

  double opacity = 0;

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
                child: SizedBox(
                  height: collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: getTextColor(shrinkOffset, true),
                        ),
                      ),
                      Opacity(
                        opacity: (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1),
                        child: titleView!,
                      ),
                      IconButton(
                        onPressed: () {
                          print("点击了分享");
                        },
                        icon: Icon(
                          Icons.share,
                          color: getTextColor(shrinkOffset, true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getBkgColor(double shrinkOffset) {
    final double opacity = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    return Color.fromRGBO(0xff, 0xff, 0xff, opacity);
  }

  Color getTextColor(double shrinkOffset, bool isIcon) {
    if (shrinkOffset <= 50) {
      //偏移较小时，默认透明
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      //下滑文字慢慢变成黑色，白底
      final double opacity = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
      return Color.fromRGBO(0, 0, 0, opacity);
    }
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    //是否支持重新构建，如果为false，即使外部更新属性，组件也不会被重新构建，根据需要设置即可
    return false;
  }
}