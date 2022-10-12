
import 'package:flutter/material.dart';
import 'package:flutter_list_demo/adapt.dart';

class ListTableView extends StatelessWidget {
  const ListTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // physics: const AlwaysScrollableScrollPhysics(
      //   parent: BouncingScrollPhysics(), //两端都拥有弹性效果
      // ),
      //这里是ListView的基本属性，都在
      padding: const EdgeInsets.all(5),
      //数量以及items，必须选项
      itemCount: 10,
      itemBuilder: (context, index) {
        return SizedBox(
          height: 60,
          child: ListTile(
            leading: const SizedBox(
              width: 50,
              height: 50,
              child: CircleAvatar(
                backgroundColor: Colors.cyanAccent,
              ),
            ),
            title: Text(
              "标题:$index",
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            subtitle: Text(
              "我是第$index条内容",
              style:
              const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ),
        );
      },
    );
  }
}
