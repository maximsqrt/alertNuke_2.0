class CalendarSlotHelper {
    static int getSlotFromTime(DateTime time){
        int hour = time.hour;
        int minute = time.minute;

        bool hasHalfHour = minute == 30;

        int hourIndex = (hour * 100) ~/ 50; // 4 Uhr -> 4 * 100 -> 400 / 50 = 8 + 1 = 9

        int index = hourIndex + (hasHalfHour ? 1 : 0);

        return index;
    }
}