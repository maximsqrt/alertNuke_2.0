import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class IconWithName {
  final IconData icon;
  final String name;
  final String iconDescription;
  
  IconWithName({required this.icon, required this.name, required this.iconDescription});
}
abstract class IconRepository{
  Future<void> addIconDataCollection(String userId, IconData iconData, String iconText, String iconDescription);

  Future<String?> getCurrentUserId();
}

final savedIconsProvider = ChangeNotifierProvider<SavedIconsNotifier>(
  create: (context) => SavedIconsNotifier(),
);

class SavedIconsNotifier extends ChangeNotifier {
  List<IconWithName> _icons = [];

  List<IconWithName> get icons => _icons;

  void addIcon(IconWithName iconWithName) {
    _icons = [..._icons, iconWithName];
    notifyListeners();
  }

  void updateIcons(List<IconWithName> icons) {
    _icons = List.from(icons);
    notifyListeners();
  }
}
