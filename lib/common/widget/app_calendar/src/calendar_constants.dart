class CalendarConstants {
  static const Map<String, dynamic> monthJapan = {
    // "いちがつ": 1,
    // "にがつ": 2,
    // "さんがつ": 3,
    // "しがつ": 4,
    // "ごがつ": 5,
    // "ろくがつ": 6,
    // "しちがつ": 7,
    // "はちがつ": 8,
    // "きゅうがつ": 9,
    // "じゅうがつ": 10,
    // "じゅういちがつ": 11,
    // "じゅうにがつ": 12,
    "1月": 1,
    "2月": 2,
    "3月": 3,
    "4月": 4,
    "5月": 5,
    "6月": 6,
    "7月": 7,
    "8月": 8,
    "9月": 9,
    "10月": 10,
    "11月": 11,
    "12月": 12,
  };
  static const List<String> dayJapan = [
    "日",
    "月",
    "火",
    "水",
    "木",
    "金",
    "土",
  ];
  static const dayOfWeek = 7;
  static const int minDayInMonth = 28;
  static const int startDayInWeek = 7;
}

enum CalendarMode { DAY, MONTH }
