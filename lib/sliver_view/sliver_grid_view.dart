import 'package:flutter/material.dart';

const List<String> tabNames = [
  "包含SliverGrid.count",
  "SliverGrid.extend",
  "SliverGrid.builder"
];

//包含SliverGrid.count、SliverGrid.extend、SliverGrid.builder
class SliverGridView extends StatelessWidget {
  const SliverGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomScrollView(
          slivers: <Widget>[
            getTitle("SliverGrid.count固定列数语法糖"),
            getGridCountWidget(),
            getTitle("SliverGrid.extend最大列宽语法糖"),
            getGridExtentWidget(),
            getTitle("未发现固定列宽复用语法糖"),
            getTitle("SliverGrid复用的固定列数通用案例-更新delegate可切换类型"),
            getGridBuilderFixCrossWidget(),
            getTitle("SliverGrid复用的最大列宽通用案例-更新delegate可切换类型"),
            getGridBuilderMaxCrossWidget(),
          ],
        ),
      )
    );
  }

  Widget getTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  //固定列数的语法糖
  Widget getGridCountWidget() {
    return SliverGrid.count(
      crossAxisCount: 6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 1, //宽高比，想高一点，就介于0~1之间即可
      children:
          [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4].map<Widget>((e) {
        return Container(
          color: Colors.red,
        );
      }).toList(),
    );
  }

  //单个item最大行宽语法糖
  Widget getGridExtentWidget() {
    return SliverGrid.extent(
      maxCrossAxisExtent: 80,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 1, //宽高比，想高一点，就介于0~1之间即可
      children:
          [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4].map<Widget>((e) {
        return Container(
          color: Colors.green,
        );
      }).toList(),
    );
  }

  //复用builder固定列数
  Widget getGridBuilderFixCrossWidget() {
    return SliverGrid(
      //固定列数
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1, //宽高比，想高一点，就介于0~1之间即可
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            color: Colors.blue,
          );
        },
        childCount: 4,
      ),
    );
  }

  //复用builder最大列宽
  Widget getGridBuilderMaxCrossWidget() {
    return SliverGrid(
      //最大列宽
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1, //宽高比，想高一点，就介于0~1之间即可
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            color: Colors.yellow,
          );
        },
        childCount: 4,
      ),
    );
  }
}
