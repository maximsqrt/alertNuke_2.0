
import 'package:alertnukeapp_ver2/src/Services/icon_services/firebase_icon_repositorys.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';

class IconService {
  final FirebaseIconRepository _iconRepository;
  final SavedIconsNotifier _savedIconsNotifier;

  IconService(this._iconRepository, this._savedIconsNotifier);

  Future<List<IconWithName>> fetchIcons() async {
    String? userId = await _iconRepository.getCurrentUserId();
    if (userId != null) {
      List<IconWithName> icons = await _iconRepository.getIcondataCollection(userId);
      _savedIconsNotifier.updateIcons(icons);
      return icons;
    } else {
      print('User ID is null');
      return []; // Return an empty list if there's no user ID
    }
  }
}

