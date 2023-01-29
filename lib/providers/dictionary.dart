import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zineapp2023/providers/dictionary/about_dict.dart';
import 'package:zineapp2023/providers/dictionary/project_dict.dart';
import 'package:zineapp2023/providers/dictionary/team_dict.dart';

class Language extends ChangeNotifier {

  late AboutScreen aboutScreen;
  late ProjectScreen projectScreen;
  late TeamScreen teamScreen;

  init() async {
    var json = await loadLanguageJSON();
    aboutScreen = AboutScreen.fromJson(json["about"]);
    projectScreen = ProjectScreen.fromJson(json["project"]);
    teamScreen = TeamScreen.fromJson(json["team"]);
    notifyListeners();
  }

  Future<dynamic> loadLanguageJSON() async {
    final String response =
        await rootBundle.loadString("assets/screenData.json");
    final json = await jsonDecode(response);
    return json;
  }
}
