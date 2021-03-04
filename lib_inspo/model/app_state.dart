import 'package:access_control_flutter/managers/database/drink_history.dart';
import 'package:access_control_flutter/model/settings/AppSettings.dart';
import 'package:access_control_flutter/model/water/Glass.dart';

class AppState {
  final AppSettings settings;
  final Glass glass;
  final List<DrinkHistoryEntry> drinksHistory;

  AppState({this.settings, this.glass, this.drinksHistory});

  factory AppState.defaultState() {
    var settings = AppSettings(dailyGoal: 0);
    var glass = Glass(0, 0);
    return AppState(settings: settings, glass: glass, drinksHistory: []);
  }
}
