
import 'package:flutter/cupertino.dart';
import 'package:flutter_list_demo/gird_view/index.dart';
import 'package:flutter_list_demo/list_view/index.dart';
import 'package:flutter_list_demo/sliver_view/index.dart';
import 'package:flutter_list_demo/sliver_view/nest_persistent_head_tabbar_view1.dart';
import 'package:flutter_list_demo/sliver_view/nest_persistent_head_tabbar_view2.dart';
import 'tabbar/bottom_bar.dart';

const String normalListView = "NormalListView";
const String normalGridView = "NormalGridView";
const String normalSliverView = "NormalSliverView";
const String normalTabBar = "NormalTabBar";

const String nestPersistentHeaderTabbarView1 = "NestPersistentHeaderTabbarView1";
const String nestPersistentHeaderTabbarView2 = "NestPersistentHeaderTabbarView2";

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    normalListView: (context) => const NormalListView(),
    normalGridView: (context) => const NormalGridView(),
    normalSliverView: (context) => const NormalSliverView(),
    normalTabBar: (context) => const NormalTabBar(),
    nestPersistentHeaderTabbarView1: (context) => const NestPersistentHeaderTabbarView1(),
    nestPersistentHeaderTabbarView2: (context) => const NestPersistentHeaderTabbarView2(),
  };
}
