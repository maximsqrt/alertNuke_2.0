
import 'package:alertnukeapp_ver2/src/presentation/icons/iconswithnameslist.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

class IconList extends StatelessWidget {
  final List<IconData> icons;
  final void Function(BuildContext, IconData) onTap;

  const IconList({
    Key? key,
    required this.icons,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: namesWithIconsList.length,
      itemBuilder: (context, index) {
        final String iconName = namesWithIconsList.keys.elementAt(index);
        final IconData icon = namesWithIconsList[iconName]!;
        return ListTile(
          onTap: () => onTap(context, icon),
          leading: Icon(icon, color: FancyFontColor.primaryColor),
          title: Text(iconName,style: TextStyle( color: FancyFontColor.primaryColor ),),
        );
      },
    );
  }



}

