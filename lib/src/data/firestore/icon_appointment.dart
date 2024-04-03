
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IconAppointment {
  final IconWithName iconWithName;
  final DateTime appointmentDate;
  final String appointmentDescription;
  ///Optional für Apoinzments 
  final double? iconPosition;

  factory IconAppointment.fromMap(Map<String,dynamic> map ){
    var iconCodePoint = map['iconCodePoint'].toInt();
    var icon = IconData(iconCodePoint, fontFamily: 'UniconsLine', fontPackage: 'unicons');
    var name = map['iconName'];
    var description = map['iconDescription']; // Hinzugefügt für Vollständigkeit
    var appointmentDate = (map['appointmentDate'] as Timestamp).toDate();

    return IconAppointment(iconWithName: IconWithName(icon: icon, name: name, iconDescription: description), appointmentDate: appointmentDate, appointmentDescription: description);
  }

  IconAppointment({
    required this.iconWithName,
    required this.appointmentDate,
    required this.appointmentDescription,
    this.iconPosition,
  });
}