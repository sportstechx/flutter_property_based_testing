extension PadInteger on int {
  String toPaddedString() => (this <= 9) ? "0$this" : "$this";
}

class AgeManager {
  bool checkLegalAge(int year, int month, int day) =>
      DateTime.now().millisecondsSinceEpoch >=
      getLegalAgeTime(DateTime.parse("$year${month.toPaddedString()}${day.toPaddedString()}")).millisecondsSinceEpoch;

  DateTime getLegalAgeTime(DateTime birthday) {
    int delta = 5;
    return birthday.add(Duration(days: 365 * 18 + delta));
  }
}
