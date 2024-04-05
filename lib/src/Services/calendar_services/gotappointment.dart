




import 'package:alertnukeapp_ver2/src/data/firestore/displayappointment.dart';
import 'package:alertnukeapp_ver2/src/presentation/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class AppointmentUtils {
  static Future<bool> hasAppointmentsOnDay(DateTime date) async {
    final userId = FirebaseAuth.instance.currentUser?.uid; // Get current user ID
    if (userId == null) return false; // Ensure user is logged in

    // Format the start and end of the day for the query
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    // Query Firestore for appointments on the given day
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Appointments')
        .where('appointmentDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('appointmentDate', isLessThan: Timestamp.fromDate(endOfDay))
        .get();

    return querySnapshot.docs.isNotEmpty; // True if appointments exist, false otherwise
  }
}