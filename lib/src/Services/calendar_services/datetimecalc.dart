class DateTimeCalc {
  // Konstruktor, der das Jahr als Argument nimmt
  DateTimeCalc(this.year);

  final int year;

  // Eine Methode, die die Anzahl der Tage in einem bestimmten Monat zurückgibt
  int daysInMonth(int month) {
    // Monate mit 31 Tagen
    if ([1, 3, 5, 7, 8, 10, 12].contains(month)) {
      return 31;
    }
    // Monate mit 30 Tagen
    else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    // Februar
    else {
      // Überprüfung auf Schaltjahr
      if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
        return 29;
      } else {
        return 28;
      }
    }
  }

  // Eine Methode, die die Gesamtanzahl der Tage im Jahr zurückgibt
  int daysInYear() {
    if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
      return 366;
    } else {
      return 365;
    }
  }

  // Eine Methode, die eine Liste der Tage jedes Monats im Jahr zurückgibt
  List<int> daysInEachMonth() {
    return List<int>.generate(12, (index) => daysInMonth(index + 1));
  }
}
