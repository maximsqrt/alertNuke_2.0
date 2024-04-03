


import 'package:alertnukeapp_ver2/src/Services/icon_services/firebase_icon_repositorys.dart';
import 'package:alertnukeapp_ver2/src/Services/icon_services/iconservice.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///DialogWindow for choosing ICONS
class SymbolTap extends StatelessWidget {
  const SymbolTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  SavedIconsNotifier for storing/fetching icons
    final iconRepository =
        Provider.of<FirebaseIconRepository>(context, listen: false);
    final iconsNotifier =
        Provider.of<SavedIconsNotifier>(context, listen: false);

    return AlertDialog(
      title: const Text('Choose Your Icon'),
      content: Container(
        // Define a fixed height for the container, or make it dynamic based on content or screen size as needed
        height: 200, // Example fixed height
        width: double.maxFinite, // Use the maximum width available
        child: FutureBuilder<List<IconWithName>>(
          future: IconService(iconRepository, iconsNotifier)
              .fetchIcons(), // Implement this method to fetch icons from Firebase
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            final icons = snapshot.data ?? [];
            return ListView.builder(
              shrinkWrap: true,
              itemCount: icons.length,
              itemBuilder: (context, index) {
                final iconWithNamedata = icons[index];
                // Recreate the IconData to ensure all properties are correctly applied
                IconData recreatedIconData = IconData(
                  iconWithNamedata.icon.codePoint,
                  fontFamily: iconWithNamedata.icon.fontFamily,
                  fontPackage:
                      'unicons', // Ensure this matches the exact package name used in pubspec.yaml
                  matchTextDirection: iconWithNamedata.icon.matchTextDirection,
                );

                return ListTile(
                  leading: Icon(
                      recreatedIconData), // Use the recreated IconData object directly
                  title: Text(iconWithNamedata.name),
                  onTap: () => Navigator.of(context).pop(iconWithNamedata),
                );
              },
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cdancel'),
        ),
      ],
    );
  }
}
