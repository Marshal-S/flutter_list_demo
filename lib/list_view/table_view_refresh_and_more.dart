
import 'dart:async';
import 'package:flutter/material.dart';

//下拉刷新与上拉加载
class RefreshListView extends StatefulWidget {
  const RefreshListView({Key? key}) : super(key: key);

  @override
  State<RefreshListView> createState() => _RefreshListViewState();
}

class _RefreshListViewState extends State<RefreshListView> {
  int count = 20;
  bool isLoading = false;

  //默认会返回一个 Future，也可以自己return一个
  Future<void> onRefresh() async {
    print("12312313");
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      count = 20;
    });
  }

  //这两种都可以，根据需要来进行处理即可
  //不是说下面麻烦就没有使用场景了
  //如果不能很好await，可以采用下面方案
  Future<void> onRefresh2() {
    print("12312313");
    var completer = Completer<void>();
    return Future(() async {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        count = 5;
      });
      completer.complete();
    });
  }

  void loadMore() {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        count += 20;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: NotificationListener<ScrollNotification>(
        //滑动监听，通过更新类名来区分监听信息
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.maxScrollExtent - notification.metrics.pixels <= 100) {
             loadMore();
          }
          //继续向上冒泡事件
          return false;
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(), //两端都拥有弹性效果
          ),
          //这里是ListView的基本属性，都在
          padding: const EdgeInsets.all(5),
          //数量以及items，必须选项
          itemCount: count + 1,
          itemBuilder: (context, index) {
            if (index >= count) {
              return renderBottom();
            }
            return SizedBox(
              height: 60,
              child: ListTile(
                leading: const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
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
        ),
      ),
    );
  }

  Widget renderBottom() {
    if(isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '加载中...',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: const Text(
          '上拉加载更多',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF333333),
          ),
        ),
      );
    }
  }
}

