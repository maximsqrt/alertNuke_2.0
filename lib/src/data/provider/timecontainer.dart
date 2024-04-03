
import 'package:alertnukeapp_ver2/src/Services/calendar_services/calendarslothelper.dart';
import 'package:alertnukeapp_ver2/src/data/firestore/appointments.dart';
import 'package:alertnukeapp_ver2/src/data/firestore/icon_appointment.dart';
import 'package:alertnukeapp_ver2/src/data/provider/savediconsprovider.dart';
import 'package:alertnukeapp_ver2/src/data/provider/symboltap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


///Class for display Appointments in 30min gaps
class TimeContainer extends StatelessWidget {
  final ScrollController timeController;
  final DateTime selectedDate;

  TimeContainer(
      {Key? key, required this.timeController, required this.selectedDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<User?>(context)?.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection('Appointments')
            .where('appointmentDate',
                isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(
                    selectedDate.year, selectedDate.month, selectedDate.day)),
                isLessThan: Timestamp.fromDate(DateTime(selectedDate.year,
                    selectedDate.month, selectedDate.day + 1)))
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();

          List<IconAppointment> icons = [];

          for (QueryDocumentSnapshot doc in snapshot.data!.docs) {
            var appointmentData = doc.data() as Map<String, dynamic>;
            IconAppointment iconAppointment =
                IconAppointment.fromMap(appointmentData);
            icons.add(iconAppointment);
          }

          List<Widget> appointmentWidgets = [];

          return ListView.builder(
            controller: timeController,
            itemCount: 48, // Represents each half-hour slot in a 24-hour day
            itemBuilder: (context, index) {
              final hour = index ~/ 2; // Integer division to get the hour
              final minute = (index % 2) *
                  30; // Multiply the remainder to get the minutes (0 or 30)

              bool foundAppointment = false;

              for (IconAppointment appointment in icons) {
                int iconIndex = CalendarSlotHelper.getSlotFromTime(
                    appointment.appointmentDate);

                if (iconIndex == index) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0), //
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(113, 162, 166, 170),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text(
                              '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize:
                                    16, // Increased font size for better visibility
                              ),
                            )),
                        SizedBox(width: 5),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              appointment.iconWithName.icon,
                              color: Colors.white,
                            ),
                            SizedBox(width: 2),
                            Text(
                              "${appointment.iconWithName.name} - ${appointment.iconWithName.iconDescription}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                      ]);
                }
              }

              return GestureDetector(
                  onTap: () =>
                      _showIconSelectionDialog(context, hour, minute, index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0), // Increased padding
                    child: Text(
                      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            16, // Increased font size for better visibility
                      ),
                    ),
                  ));
            },
          );
        });
  }

  Future<void> _showIconSelectionDialog(
      BuildContext context, int hour, int minute, int position) async {
    final IconWithName? selectedIcon = await showDialog<IconWithName>(
      context: context,
      builder: (context) => const SymbolTap(),
    );

    if (selectedIcon != null) {
      print("Selected Icon: ${selectedIcon.name} for time $hour:$minute");

      // Datum und Uhrzeit für den Termin festlegen
      DateTime appointmentDate = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, hour, minute);

      // Benutzer-ID abrufen
      String? userId =
          await FirebaseIconAppointmentRepository().getCurrentUserId();

      if (userId != null) {
        // IconAppointment Instanz erstellen
        IconAppointment appointment = IconAppointment(
          iconWithName: selectedIcon,
          appointmentDate: appointmentDate,
          iconPosition: position.toDouble(),
          appointmentDescription: "Beschreibung hier einfügen",
          // Füge eine Möglichkeit hinzu, eine Beschreibung zu erfassen
        );

        // Termin in Firebase speichern
        await FirebaseIconAppointmentRepository()
            .addIconAppointment(userId, appointment);

        // Optional: Bestätigung anzeigen oder den State aktualisieren
      } else {
        // Handle User not logged in
      }
    }
  }
}
