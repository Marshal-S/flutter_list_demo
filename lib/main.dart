import 'package:flutter/material.dart';
import 'package:flutter_list_demo/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter List Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        //更新 Appbar的默认toolbar高度
        appBarTheme: const AppBarTheme(
          toolbarHeight: 44,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: getRoutes(context),
    );
  }
}

class DemoModel {
  final String title;
  final String desc;
  final String navigateName;

  const DemoModel(this.title, this.desc, this.navigateName);
}

const List<DemoModel> listInfos = [
  DemoModel("ListView", "ListView使用介绍演示", normalListView),
  DemoModel("GridView", "GridView使用介绍演示", normalGridView),
  DemoModel("SliverView", "SliverView使用介绍演示", normalSliverView),
  DemoModel("TabBar", "TabBar简介", normalTabBar)
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: listInfos.map<Widget>((DemoModel item) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: TextButton(
              style: ButtonStyle(
                //设置颜色，注意由于button有点击效果，所以可能有多重颜色，可以根据状态states设置颜色
                // backgroundColor: MaterialStateProperty.resolveWith((states) {
                //   if (states.contains(MaterialState.pressed)) {
                //     return Colors.grey;
                //   }
                //   return Colors.white;
                // }),
                //所有的都设置成一样的
                backgroundColor: MaterialStateProperty.all(Colors.cyanAccent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
              ),
              onPressed: () {
                Navigator.pushNamed(context, item.navigateName);
              },
              child: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      item.desc,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black45
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
