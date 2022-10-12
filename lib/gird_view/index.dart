

import 'package:flutter/material.dart';
import 'package:flutter_list_demo/gird_view/default_grid_view.dart';
import 'package:flutter_list_demo/gird_view/grid_builder_view.dart';
import 'package:flutter_list_demo/gird_view/grid_count_view.dart';
import 'package:flutter_list_demo/gird_view/grid_extent_view.dart';

const List<String> tabNames = ["GridView", "GridView.count", "GridView.extent", "GridView.builder"];

class NormalGridView extends StatelessWidget {
  const NormalGridView({Key? key}) : super(key: key);

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
            title: const Text('GridView'),
            bottom: TabBar(
              isScrollable: true,
              tabs: tabNames
                  .map((text) => Tab(text: text))
                  .toList(),
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            DefaultGridView(),
            GridCountView(),
            GridExtentView(),
            GridBuildView(),
          ],
        ),
      ),
    );
  }
}
