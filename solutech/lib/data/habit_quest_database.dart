import 'package:hive_flutter/adapters.dart';
import 'package:solutech/data/date_time.dart';
import 'package:solutech/models/habit.dart';

final _myBox = Hive.box('Habit_quest_Database');

class HabitQuestDatabase {
  List<Habit> todayHabitList = [];

  //create
  void createDefault() {
    _myBox.put("START_DATE", todaysDateFormatted());
  }

  //load
  void loadDate() {
    //if its a new day and is daily is true
    if (_myBox.get(todaysDateFormatted()) == null) {
      todayHabitList = _myBox.get("CURRENT_HABIT_LIST");
    }

    //if its not a new day and is daily is not true
    else {}
  }

  //update
}
