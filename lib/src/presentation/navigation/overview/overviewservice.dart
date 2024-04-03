

import 'package:alertnukeapp_ver2/src/presentation/calendar/calendar.dart';
import 'package:alertnukeapp_ver2/src/presentation/chat/chat.dart';
import 'package:alertnukeapp_ver2/src/presentation/icons/icons_screen.dart';
import 'package:alertnukeapp_ver2/src/presentation/maps/maps.dart';
import 'package:alertnukeapp_ver2/src/presentation/settings/settingsscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OverviewService {

    static int selectedIndex = 0;

    static List<Widget> widgetOptions = <Widget>[
     Calendar(),
     MapCalendar(),
     const ChatsCalendar(),
     const IconsScreen(),
     SettingsScreen(),
  ];


} 