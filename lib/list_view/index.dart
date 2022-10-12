import 'package:flutter/material.dart';
import 'package:flutter_list_demo/list_view/separated_table_list.dart';
import 'package:flutter_list_demo/list_view/table_view_list.dart';
import 'package:flutter_list_demo/list_view/table_view_refresh_and_more.dart';
import 'default_list_view.dart';

const List<String> tabNames = ["ListView", "ListView.builder", "ListView.separated", "RefreshListView"];

class NormalListView extends StatelessWidget {
  const NormalListView({Key? key}) : super(key: key);

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
            title: const Text('ListView'),
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
            DefaultListView(),
            ListTableView(),
            ListSeparatedTableView(),
            RefreshListView()
          ],
        ),
      ),
    );
  }
}
