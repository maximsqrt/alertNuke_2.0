
import 'package:alertnukeapp_ver2/src/Services/calendar_services/calendarslothelper.dart';
import 'package:alertnukeapp_ver2/src/data/firestore/icon_appointment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AppointmentsDisplay extends StatelessWidget {
  final DateTime selectedDate;

  AppointmentsDisplay({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<User?>(context)?.uid;
String usercollectionname = 'users';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(usercollectionname)
          .doc(userId)
          .collection('Appointments')
          .where('appointmentDate', 
       isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime(selectedDate.year, selectedDate.month, selectedDate.day)),
       isLessThan: Timestamp.fromDate(DateTime(selectedDate.year, selectedDate.month, selectedDate.day + 1)))

          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        


        List<IconAppointment> icons = [];

    
        for(QueryDocumentSnapshot doc in snapshot.data!.docs){
          var appointmentData = doc.data() as Map<String, dynamic>;
          IconAppointment iconAppointment = IconAppointment.fromMap(appointmentData);
          icons.add(iconAppointment);
        }
       

         print("After snapshot: ${icons.length}");

        List<Widget> appointmentWidgets = [];



for(int i = 1; i <= 48; i++){
  
            bool foundAppointment = false;
           for(IconAppointment appointment in icons){
            int iconIndex = CalendarSlotHelper.getSlotFromTime(appointment.appointmentDate);
            int index = i;

            
              if(iconIndex == index){
                   appointmentWidgets.add(Padding(
                     padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                    children: [
                      Icon(appointment.iconWithName.icon),
                      SizedBox(width: 2),
                      Text("${appointment.iconWithName.name} - ${appointment.iconWithName.iconDescription}"),
                    
                    ],
                   )));
                 foundAppointment = true;
              } 
         }

         if(!foundAppointment){
          appointmentWidgets.add(Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0), // Increased padding,
            child:  Text(" "),
          ));

         }
}



        return SingleChildScrollView(
          child: Column(
            children: appointmentWidgets,
          ),
        );
      }      
    );
  }
}
