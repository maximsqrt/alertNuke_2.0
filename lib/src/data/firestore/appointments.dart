
import 'package:alertnukeapp_ver2/src/data/firestore/icon_appointment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



abstract class IconRepository {
  Future<void> addIconAppointment(
      String userId, IconAppointment iconAppointment);
  Future<String?> getCurrentUserId();
}

class FirebaseIconAppointmentRepository implements IconRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> addIconAppointment(
      String userId, IconAppointment iconAppointment) async {
   final data = {
      
      
      'iconCodePoint': iconAppointment.iconWithName.icon.codePoint,
      'iconFontFamily': iconAppointment.iconWithName.icon.fontFamily,
      'iconFontPackage': iconAppointment.iconWithName.icon.fontPackage,
      'iconName': iconAppointment.iconWithName.name,
      'iconDescription': iconAppointment.iconWithName.iconDescription,
      'appointmentDate': iconAppointment.appointmentDate,
      'appointmentDescription': iconAppointment.appointmentDescription,
    };
      // Optional: Hinzufügen der Position, wenn sie vorhanden ist
  if (iconAppointment.iconPosition != null) {
    data['iconPosition'] = iconAppointment.iconPosition;
  }
   await _firestore
      .collection('users')
      .doc(userId)
      .collection('Appointments')
      .add(data);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _auth.currentUser?.uid;
  }
}
