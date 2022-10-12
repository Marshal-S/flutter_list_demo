import 'package:flutter/material.dart';

const tabNames = ["SliverListView基础", "SliverListView复用"];

//和 ListView差不多
class SliverListView extends StatefulWidget {
  const SliverListView({Key? key}) : super(key: key);

  @override
  State<SliverListView> createState() => _SliverListViewState();
}

class _SliverListViewState extends State<SliverListView> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          getTitle("内嵌ListView固定操作"),
          getListViewWidget(),

          getTitle("内嵌SliverList复用操作"),
          getListViewBuilder(),

          getTitle("内嵌SliverList复用的固定行高语法糖"),
          getListFixedExtentBuilderWidget(),
        ],
      ),
    );
  }

  Widget getTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: const TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
      ),
    );
  }

  //使用起来和 ListView差不多
  Widget getListViewWidget() {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            color: Colors.green,
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            color: Colors.green,
            height: 100,
          ),
        ),
      ]),
    );
  }

  //可复用的ListViewBuilder
  Widget getListViewBuilder() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: Colors.red,
            height: 20,
          ),
        );
      }, childCount: 10,),
    );
  }

  //可复用的固定行高语法糖ListViewBuilder
  Widget getListFixedExtentBuilderWidget() {
    return SliverFixedExtentList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.blue,
            ),
          );
        },
        childCount: 10, //总数量
      ),
      itemExtent: 30, //固定行高
    );
  }
}
