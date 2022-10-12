import 'package:flutter/material.dart';

class ListSeparatedTableView extends StatelessWidget {
  const ListSeparatedTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(), //两端都拥有弹性效果
      ),
      //这里是ListView的基本属性，都在
      padding: const EdgeInsets.all(5),
      itemCount: 100,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          alignment: Alignment.centerLeft,
          height: 60,
          margin: const EdgeInsets.only(left: 6, right: 6),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "标题:$index",
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Text(
                        "我是第$index条内容",
                        style:
                        const TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        //返回分割线，widget，自定义container都可以
        return const Divider(
          height: 0.5,
          indent: 60, //距离左侧
          endIndent: 0, //距离右侧
          color: Colors.grey,
        );
      },
    );
  }
}
