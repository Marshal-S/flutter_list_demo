import 'package:flutter/material.dart';
import 'package:flutter_list_demo/routes.dart';
import 'package:flutter_list_demo/sliver_view/sliver_app_bar_view.dart';
import 'package:flutter_list_demo/sliver_view/sliver_grid_view.dart';
import 'package:flutter_list_demo/sliver_view/sliver_list_view.dart';
import 'package:flutter_list_demo/sliver_view/sliver_persistent_header.dart';
import 'package:flutter_list_demo/sliver_view/nested_scroll_normal_view.dart';

const List<String> tabNames = [
  "SliverList",
  "SliverGrid",
  "SliverAppBarView",
  "自定义SliverPersistentHeaderView",
  "NestedScrollNormalView",
];

class NormalSliverView extends StatelessWidget {
  const NormalSliverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabNames.length,
      child: Scaffold(
        //这里简单演示一下设置appbar的高度问题，默认56,我们一般设置44即可
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(88),
          child: AppBar(
            elevation: 0,
            title: const Text('Sliver'),
            bottom: TabBar(
              isScrollable: true,
              tabs: tabNames.map((text) => Tab(text: text)).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, nestPersistentHeaderTabbarView1);
                },
                child: const SizedBox(
                  height: 44,
                  child: Text('nestedbar1', style: TextStyle(fontSize: 14, color: Colors.white),),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, nestPersistentHeaderTabbarView2);
                },
                child: const SizedBox(
                  height: 44,
                  child: Text('nestedbar2', style: TextStyle(fontSize: 14, color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SliverListView(),
            SliverGridView(),
            SliverAppBarView(),
            SliverPersistentHeaderNormalView(),
            NestedScrollNormalView(),
          ],
        ),
      ),
    );
  }
}
