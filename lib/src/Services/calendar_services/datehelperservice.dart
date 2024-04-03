class dateHelperService {
// Other helper methods/constants
  // static int daysInMonth(int month, int year) {
   
  //   var firstDayThisMonth = DateTime(year, month, 1);
  //   var firstDayNextMonth;

  //    if (month == 12) {
  //     // Für Dezember setze den ersten Tag des nächsten Monats auf den 1. Januar des nächsten Jahres
  //     firstDayNextMonth = DateTime(year + 1, 1, 1);
  //   } else {
  //     // Für alle anderen Monate einfach den nächsten Monat verwenden
  //     firstDayNextMonth = DateTime(year, month + 1, 1);
  //   }

  //   return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  // }

  static final List<String> monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}
