import 'package:flutter/material.dart';
import 'package:flutter_list_demo/tabbar/tabbar_item.dart';
import 'dart:io';

class NormalTabBar extends StatefulWidget {
  const NormalTabBar({Key? key}) : super(key: key);

  @override
  State<NormalTabBar> createState() => _NormalTabBarState();
}

class _NormalTabBarState extends State<NormalTabBar> {
  final PageController _controller = PageController(
    initialPage: 0 //默认为0，可以不填写
  );

  final List<TabBarItem> items = [
    TabBarItem(title: '聊天', norImage: "images/tabbar_chat.png", selImage: "images/tabbar_chat_hl.png"),
    TabBarItem(title: '联系人', norImage: "images/tabbar_contact.png", selImage: "images/tabbar_contact_hl.png"),
    TabBarItem(title: '发现', norImage: "images/tabbar_discover.png", selImage: "images/tabbar_discover_hl.png"),
    TabBarItem(title: '我的', norImage: "images/tabbar_mine.png", selImage: "images/tabbar_mine_hl.png")
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int page) {
          setState(() {
            _pageIndex = page;
          });
          _controller.jumpToPage(page);
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.cyanAccent,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        items: items.map((e) {
          return BottomNavigationBarItem(
            label: e.title,
            icon: Image.asset(e.norImage,  width: 20, height: 20,),
            activeIcon: Image.asset(e.selImage, width: 20, height: 20,),
          );
        }).toList(),
      ),
      body: PageView(
        controller: _controller,
        //不设置默认可以左右活动，如果不想左右滑动如下设置，可以根据ios或者android来设置
        physics: Platform.isAndroid ? const PageScrollPhysics() : const NeverScrollableScrollPhysics(),
        children: const [
          TabbarContainerView(color: Colors.yellow, name: '1',),
          TabbarItemInAppBarView(color: Colors.cyanAccent, name: "2",),
          TabbarContainerView(color: Colors.green, name: "3",),
          TabbarItemInAppBarView(color: Colors.blueAccent, name: "4",),
        ],
      ),
    );
  }
}

class TabbarContainerView extends StatefulWidget {
  final Color color;
  final String name;
  const TabbarContainerView({Key? key, required this.color, required this.name}) : super(key: key);

  @override
  State<TabbarContainerView> createState() => _TabbarContainerViewState();
}

//继承maxin AutomaticKeepAliveClientMixin 同时重写 wantKeepAlive 可以对当前页面状态保存，避免重新渲染初始化参数
class _TabbarContainerViewState extends State<TabbarContainerView> with AutomaticKeepAliveClientMixin  {
  @override
  bool get wantKeepAlive => true;

  final List<String> tabNames = ["推荐", "订阅"];

  @override
  void initState() {
    super.initState();
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: tabNames.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("带Tabs的tabbar子页面"),
          //默认在下面放一排
          bottom: TabBar(
            tabs: tabNames.map((e) => Tab(text: e,)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabNames.map((e) {
            return TabsContainer(
              name: widget.name,
              color: widget.color,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TabbarItemInAppBarView extends StatefulWidget {
  final Color color;
  final String name;
  const TabbarItemInAppBarView({Key? key, required this.color, required this.name}) : super(key: key);

  @override
  State<TabbarItemInAppBarView> createState() => _TabbarItemInAppBarViewState();
}

class _TabbarItemInAppBarViewState extends State<TabbarItemInAppBarView> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin  {
  @override
  bool get wantKeepAlive => true;

  List<TabInfosItem> tabs = [
    TabInfosItem(name: "推荐", selected: true, index: 0),
    TabInfosItem(name: "订阅", selected: false, index: 1),
  ];

  //延迟初始化
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    print(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      //因为有返回键，所以居中有问题这里就不多设置了
      appBar: AppBar(
        //设置了之后，自动出来的返回键以及间距就没了，慎用
        // automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tabs.map((TabInfosItem item) {
              return //这里就不多介绍了，添加额外参数，自定根据点击状态调整颜色线条等
                TextButton(
                  onPressed: () {
                    _tabController.animateTo(item.index);
                    tabs.map((e) {
                      if (e.index == item.index) {
                        e.selected = true;
                      }else {
                        e.selected = false;
                      }
                      return e;
                    });
                    setState(() {});
                  },
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Text(item.name, style: TextStyle(color: item.selected ? Colors.white : Colors.grey),),
                  ),
                );
            }).toList(),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: tabs.map<Widget>((e) {
          return TabsContainer(
            name: widget.name,
            color: widget.color,
          );
        }).toList(),
      ),
    );
  }
}


class TabsContainer extends StatefulWidget {
  final Color color;
  final String name;
  const TabsContainer({Key? key, required this.name, required this.color}) : super(key: key);

  @override
  State<TabsContainer> createState() => _TabsContainerState();
}

class _TabsContainerState extends State<TabsContainer> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('TabsContainer');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        color: widget.color,
        alignment: Alignment.center,
        child: Text('我是内部页面:${widget.name}'),
      );
  }
}




