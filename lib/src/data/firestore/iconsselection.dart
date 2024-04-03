
import 'package:alertnukeapp_ver2/src/Services/icon_services/firebase_icon_repositorys.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/icons/icons_screen.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:unicons/unicons.dart'; // Importieren Sie den Provider


class IconsChoosenScreen extends StatefulWidget {
  const IconsChoosenScreen();

  @override
  _IconsChoosenState createState() => _IconsChoosenState();
}

class _IconsChoosenState extends State<IconsChoosenScreen> {
  @override
  void initState() {
    super.initState();
    _loadIcons();
  }

  Future<void> _loadIcons() async {
    String? userId = await FirebaseIconRepository().getCurrentUserId();
    print("$userId");
    if (userId != null) {
      List<IconWithName> icons =
          await FirebaseIconRepository().getIcondataCollection(userId);
      
      // Holen Sie sich eine Instanz des Providers
      var savedIconsProvider =
          Provider.of<SavedIconsNotifier>(context, listen: false);

      // Fügen Sie die Icons dem Provider hinzu
      savedIconsProvider.updateIcons(icons);
    } else {
      print('User ID is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    var savedIconsNotifier =
        Provider.of<SavedIconsNotifier>(context, listen: true);
    List<IconWithName> chosenIcons = savedIconsNotifier.icons;

    return Scaffold(
      backgroundColor: const Color.fromARGB(202, 199, 64, 181),
      appBar: AppBar(
        
        title: const Text('Chosen Icons'),
        leading: IconButton(
          icon: const Icon(UniconsLine.arrow_circle_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: chosenIcons.length < 10 ? chosenIcons.length + 1 : 10,
        itemBuilder: (context, index) {
          if (index == chosenIcons.length && chosenIcons.length < 10) {
            return ListTile(
              onTap: () {
                _showIconSelection(context);
              },
              title: const Text('Add Icon', style: TextStyle(fontSize: 24 ,color: Colors.white)),
              leading: const Icon(UniconsLine.adobe_alt, color: Colors.amber,),
            );
          } else {
            final iconWithName = chosenIcons[index];
            

// Add any other properties you want to print
            return ListTile(
              iconColor: FancyFontColor.primaryColor,
              leading: Icon(IconData(iconWithName.icon.codePoint,
                  fontFamily: iconWithName.icon.fontFamily,
                  fontPackage: 'Unicons',
                  matchTextDirection: iconWithName.icon.matchTextDirection)),
              title: Text(iconWithName.name),
              subtitle: Text(iconWithName.iconDescription),
              // Add any other relevant information here
            );
          }
        },
      ),
    );
  }
}

Future<void> _showIconSelection(BuildContext context) async {
  // Navigiere zur Seite, auf der der Benutzer ein Icon auswählen kann
  IconData? selectedIcon = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const IconsScreen()),
  );

  // Wenn ein Icon ausgewählt wurde, füge es dem Provider hinzu
  if (selectedIcon != null) {
    String name = ''; // Namen des ausgewählten Icons
    String iconDescription = ''; // Beschreibung des ausgewählten Icons

    // Holen Sie sich eine Instanz des Providers
    var savedIconsProvider =
        Provider.of<SavedIconsNotifier>(context, listen: false);

    // Füge das ausgewählte Icon zum Provider hinzu
    savedIconsProvider.addIcon(IconWithName(
      icon: selectedIcon,
      name: name,
      iconDescription: iconDescription,
    ));
  }
}
