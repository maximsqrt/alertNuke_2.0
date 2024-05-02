import 'dart:io';
import 'package:alertnukeapp_ver2/src/Services/auth_login_service.dart';
import 'package:alertnukeapp_ver2/src/Services/firebaseuserdata.dart';
import 'package:alertnukeapp_ver2/src/data/firestore/firebaseimagestorage.dart';
import 'package:alertnukeapp_ver2/src/data/firestore/profilepic.dart';
import 'package:alertnukeapp_ver2/src/data/provider/profilepictureprovider.dart';
import 'package:alertnukeapp_ver2/src/presentation/login/login.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:icony/icony_ikonate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

///For Name, Phone, Mail
class EditableField extends StatelessWidget {
  final String label;
  final String? value;
  final Color textColor;

  const EditableField({
    super.key,
    required this.label,
    this.value,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              const TextStyle(fontSize: 18, color: FancyFontColor.primaryColor),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: value,
        ),
      ],
    );
  }
}

class ImagePickerService {
  //Methode zur Bildwahl
  Future<File?> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    //RUfe Pickimage auf und warte
    return pickedImage != null ? File(pickedImage.path) : null;
  }
}

class SettingsScreen extends StatefulWidget {
  final AuthenticationLoginService authService = AuthenticationLoginService();

  SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String userId; // userId als nullable Variable deklariert
  String downloadUrl = '';
  late ProfilePictureProvider
      _profilePictureProvider; // Hier die Variable deklarieren

  @override
  void initState() {
    super.initState();

    ///1) initialise User
    userId = AuthenticationLoginService().getUserId() ?? "";
    print("UserID: $userId");

    ///2) get ProfilePicture URL
    _fetchProfilePictureUrl().then((_) {
      /// 3) call Provider for ProfilePic Provider
      _profilePictureProvider =
          Provider.of<ProfilePictureProvider>(context, listen: false);

      ///4. Profilpictue-URL
      _profilePictureProvider.updateProfilePictureUrl(downloadUrl);
    });
  }

  Future<void> _fetchProfilePictureUrl() async {
    ///get ProfilPic Url
    String? url =
        await FirebaseImageStorageService().getProfilePictureUrl(userId);
    //check if URL is not null
    if (url != null) {
      setState(() {
        downloadUrl = url;
      });
    } else {
      // Handle error when URL is null
      print("Error occurred while fetching profile picture URL");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _profilePictureProvider =
        Provider.of<ProfilePictureProvider>(context, listen: false);
    _fetchProfilePictureUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(189, 255, 255, 255)),),
        leading: IconButton(
            icon: Icon(UniconsLine.exit),
            onPressed: () {
              logout(context);
            }),
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
      body: Container(
        decoration: BoxDecoration(
          gradient: SettingsBackgroundColor.linearGradient(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(child: ProfilePictureWidget(userId: userId)),

              const SizedBox(height: 20),
              const Text(
                'Your Fancy Profile',
                style: TextStyle(
                    fontSize: 20,
                    color: FancyFontColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              EditableField(
                  textColor: Colors.white,
                  label: 'Name:',
                  value: FirebaseUserData
                      .username), // Use your FirebaseUserData here
              const SizedBox(height: 10),
              const EditableField(
                 textColor: Colors.white,
                  label: 'Phone Number:',
                  value: ''), // Provide phone number value if available
              const SizedBox(height: 10),
              EditableField(
                 
                  label: 'Email Address:',
                  value: FirebaseUserData.email,
                  textColor: Colors.white), // Use your FirebaseUserData here
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 56, 
        height: 56,
        decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: FancyButtonColor.linearGradient()),
        
        child: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ProfilePicScreen();
            },
          );
        },
        backgroundColor: Colors.transparent,
        child: Icon(UniconsLine.image, color: Colors.white,),
      ),
    ),);
  }
// how to add Gradient to Button : 
// floatingActionButton: Container(
//   width: 56,  // Standardbreite für FloatingActionButton
//   height: 56,  // Standardhöhe für FloatingActionButton
//   decoration: BoxDecoration(
//     shape: BoxShape.circle,
//     gradient: FancyButtonColor.linearGradient(),  // Deine gewünschten Gradientenfarben
//     ),
  
//   child: FloatingActionButton(
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => IconsChoosenScreen()),
//       );
//     },
//     backgroundColor: Colors.transparent,  // Wichtig: Hintergrundfarbe transparent setzen
//     child: Icon(UniconsLine.plus),
//     elevation: 0,  // Optional: Schatten entfernen, falls gewünscht
//   ),
// ),
// floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, /


  void logout(BuildContext context) async {
    await widget.authService.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }
  //Elevated Button kann die Style Eigenschaft benutzt werden 
  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Save'),
    );
  }
}

// ignore: unused_element, camel_case_types
class _bottomSheet extends StatelessWidget {
  const _bottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Show Modal BottomSheet'),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return ProfilePicScreen();
            },
          );
        },
      ),
    );
  }
}
