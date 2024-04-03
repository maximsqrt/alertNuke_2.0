// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Common
class ProfilePictureProvider extends ChangeNotifier {
  String? _profilePictureUrl;

  String? get profilePictureUrl => _profilePictureUrl;

  // Methode zum Aktualisieren des Profilbilds
  void updateProfilePictureUrl(String newProfilePictureUrl) {
    _profilePictureUrl = newProfilePictureUrl;
    notifyListeners(); // Benachrichtigen Sie die Abonnenten über die Aktualisierung
  }
}

// Presentation 
class ProfilePictureWidget extends StatelessWidget {
  final String userId;

  const ProfilePictureWidget({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    // Verwenden Sie Consumer, um auf das Profilbild-Provider-Objekt zuzugreifen
    return Consumer<ProfilePictureProvider>(
      builder: (context, profilePictureProvider, _) {
        String? profilePictureUrl = profilePictureProvider.profilePictureUrl;
  print(profilePictureUrl);
        if (profilePictureUrl != null && profilePictureUrl.isNotEmpty) {
    return ClipRRect(
  borderRadius: const BorderRadius.all(Radius.circular(75)),
  child: Container(
    height: 100,
    width: 100,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    child: Image.network(
      profilePictureUrl,
      fit: BoxFit.cover,
    ),
  ),
);

        } else {
          return _buildDefaultBackground();
        }
    
      },
    );
  }

  Widget _buildDefaultBackground() {
    return Image.asset(
      'assets/AlertNuke.png',
      width: 200,
    );
  }
}
