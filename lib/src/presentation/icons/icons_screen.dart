

import 'package:alertnukeapp_ver2/src/Services/auth_login_service.dart';
import 'package:alertnukeapp_ver2/src/Services/icon_services/firebase_icon_repositorys.dart';
import 'package:alertnukeapp_ver2/src/data/firestore/iconsselection.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/components/items/searchbar.dart';
import 'package:alertnukeapp_ver2/src/presentation/icons/iconlist.dart';
import 'package:alertnukeapp_ver2/src/presentation/icons/iconlist_to_screen.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
// Import the iconlist.dart file




class IconsScreen extends StatefulWidget {
  const IconsScreen({Key? key}) : super(key: key);

  @override
  _IconsScreenState createState() => _IconsScreenState();
}

class _IconsScreenState extends State<IconsScreen> {
  late IconData iconData; 
  late String iconText;
  late List<IconData> allUnicons;
  late List<IconData> filteredIcons;
  final TextEditingController searchController = TextEditingController();
  List<IconWithName> chosenIcons = []; // Define chosenIcons list


  late String userId;
  @override
  void initState() {
    super.initState();
    userId = AuthenticationLoginService().getUserId() ?? ""; // UserID initialisieren
    print("UserID: $userId");
    allUnicons = uniconsList; // Access the uniconsList from iconlist.dart
    filteredIcons = allUnicons;
  
  }

  void filterIcons(String query) {
    setState(() {
      filteredIcons = allUnicons.where((icon) {
        return icon.toString().toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(),
        title: Image.asset(
          'assets/AlertNuke.png',
          width: 200, // specify the width
          // specify the height
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF6CA7BE), Color(0xFF2E0B4B)],
            ),
          ),
        ),
      ),
      body: Container(decoration: BoxDecoration(
        gradient: SettingsBackgroundColor.linearGradient()), 
        child:
      
      Column(
        children: <Widget>[
           FancySearch(controller: searchController, onChanged: filterIcons),
          Expanded(
            
            child: IconList(icons: filteredIcons, onTap: _showNameDialog),
          ),
        ],
      ),


    ),
  floatingActionButton: Container(
  width: 56,  // Standardbreite für FloatingActionButton
  height: 56,  // Standardhöhe für FloatingActionButton
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: FancyButtonColor.linearGradient(),  // Deine gewünschten Gradientenfarben
    ),
  
  child: FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IconsChoosenScreen()),
      );
    },
    backgroundColor: Colors.transparent,  // Wichtig: Hintergrundfarbe transparent setzen
    child: Icon(UniconsLine.plus),
    elevation: 0,  // Optional: Schatten entfernen, falls gewünscht
  ),
),
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Position FAB at the bottom right
// Position FAB at the bottom right
  );
    
  }


Future<void> _showNameDialog(BuildContext context, IconData icon) async {
  final TextEditingController controller = TextEditingController();

  final iconName = await showDialog<String?>(
    context: context,
    builder: (_) => NameDialog(
      icon: icon,
    ),
  );
if (iconName != null) {
      final String userId = AuthenticationLoginService().getUserId() ?? "";
      // Assign iconData the value of the current icon
      
    }
  }





}

class NameDialog extends StatelessWidget {
  final IconData icon;

  const NameDialog({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
final TextEditingController descriptionController = TextEditingController();
    return AlertDialog(
      title: const Text('Name your icon'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 24),
              const SizedBox(width: 10),
              const Text('Icon'),
            ],
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Enter icon name'),
          ),
           const SizedBox(height: 10), // Spacer
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Enter icon description'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
        onPressed: () async {
            String iconName = controller.text;
            String iconDescription = descriptionController.text;
            if (iconName.isNotEmpty) {
              // Speichern  Daten in Firebase
              IconRepository repository = FirebaseIconRepository();
              String? userId = await repository.getCurrentUserId();
              if (userId != null) {
                await repository.addIconDataCollection(userId, icon, iconName, iconDescription);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Icon data uploaded')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User not logged in')));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a name for the icon')));
            }
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}



