import 'package:flutter/cupertino.dart';
import 'package:zineapp2023/screens/explore/about/about.dart';
import 'package:zineapp2023/screens/explore/project.dart';
import 'package:zineapp2023/screens/explore/team/team.dart';
import 'package:zineapp2023/screens/explore/explore.dart';

class RouteName {
  static const teamScreen = "team";
  static const achievementScreen = "achievement";
  static const projectScreen = "project";
  static const aboutMe = "about";
  static const wokrshopTimeline = "timeline";
  static const exploreScreen = "explore";
  static const homeScreen = "home";
}

class Routes {
  static cupertinoRoute(
          String name, Widget Function(BuildContext) widgetProvider) =>
      CupertinoPageRoute(
        settings: RouteSettings(name: name),
        builder: (context) => widgetProvider(context),
      );

  static Route teamScreen() =>
      cupertinoRoute(RouteName.teamScreen, (ctx) => const TeamScreen());

  // static Route achievementScreen() => cupertinoRoute(RouteName.achievementScreen, (ctx)=> const TeamScreen());
  static Route projectScreen() =>
      cupertinoRoute(RouteName.projectScreen, (ctx) => const ProjectScreen());

  static Route aboutMe() =>
      cupertinoRoute(RouteName.aboutMe, (ctx) => const AboutScreen());

  // static Route workshopTimeline() => cupertinoRoute(RouteName.wokrshopTimeline, (ctx)=> const TeamScreen());
  static Route exploreScreen() =>
      cupertinoRoute(RouteName.exploreScreen, (ctx) => const Explore());
}