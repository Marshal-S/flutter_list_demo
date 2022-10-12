
class TabBarItem {
  final String title;
  final String norImage;
  final String selImage;

  TabBarItem({
    required this.title,
    required this.norImage,
    required this.selImage
  });
}

class TabInfosItem {
  final String name;
  final int index;
  bool selected;

  TabInfosItem({
    required this.name,
    required this.selected,
    required this.index
  });
}