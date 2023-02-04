import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dictionary/about_dict.dart';
import 'dictionary/project_dict.dart';
import 'dictionary/team_dict.dart';
import 'dictionary/achievements_dict.dart';

class Language extends ChangeNotifier {

  late AboutScreenDict aboutScreen;
  late ProjectScreenDict projectScreen;
  late TeamScreenDict teamScreen;
  late AchievementScreenDict achievementScreen;

  init() async {
    var json = await loadLanguageJSON();
    aboutScreen = AboutScreenDict.fromJson(json["about"]);
    projectScreen = ProjectScreenDict.fromJson(json["project"]);
    teamScreen = TeamScreenDict.fromJson(json["team"]);
    achievementScreen = AchievementScreenDict.fromJson(json["achievement"]);
    notifyListeners();
  }

  Future<dynamic> loadLanguageJSON() async {
    final String response =
        await rootBundle.loadString("assets/screenData.json");
    final json = await jsonDecode(response);
    return json;
  }
}
