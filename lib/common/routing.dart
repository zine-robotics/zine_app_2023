import 'package:flutter/cupertino.dart';
import 'package:zineapp2023/screens/explore/achievements.dart';
import 'package:zineapp2023/screens/explore/team/team.dart';
import 'package:zineapp2023/screens/explore/explore.dart';
import 'package:zineapp2023/screens/home/home_screen.dart';
import 'package:zineapp2023/screens/onboarding/landing.dart';
import 'package:zineapp2023/screens/onboarding/reset_password/email_screen.dart';
import 'package:zineapp2023/screens/onboarding/reset_password/otp_screen.dart';

import '../screens/dashboard/profile.dart';
import '../screens/explore/about/about.dart';
import '../screens/explore/project.dart';

class RouteName {
  static const landingScreen = "landingScreen";
  static const teamScreen = "team";
  static const achievementScreen = "achievement";
  static const projectScreen = "project";
  static const aboutMe = "about";
  static const wokrshopTimeline = "timeline";
  static const exploreScreen = "explore";
  static const homeScreen = "home";
  static const profileScreen = "profile";
  static const emailScreen = "email";
  static const otpScreen = "otp";
}

class Routes {

  static cupertinoRoute(
          String name, Widget Function(BuildContext) widgetProvider) =>
      CupertinoPageRoute(
        settings: RouteSettings(name: name),
        builder: (context) => widgetProvider(context),
      );

  static Route landingScreen()=>
  cupertinoRoute(RouteName.landingScreen, (ctx) => const LandingScreen());

  static Route homeScreen() =>
      cupertinoRoute(RouteName.homeScreen, (ctx) => const Home());

  static Route teamScreen() =>
      cupertinoRoute(RouteName.teamScreen, (ctx) => const TeamScreen());

  static Route achievementScreen() => cupertinoRoute(
      RouteName.achievementScreen, (ctx) => const AchievementScreen());

  static Route projectScreen() =>
      cupertinoRoute(RouteName.projectScreen, (ctx) => const ProjectScreen());

  static Route aboutMe() =>
      cupertinoRoute(RouteName.aboutMe, (ctx) => const AboutScreen());

  // static Route workshopTimeline() => cupertinoRoute(RouteName.wokrshopTimeline, (ctx)=> const ());

  static Route exploreScreen() =>
      cupertinoRoute(RouteName.exploreScreen, (ctx) => const Explore());

  static Route profileScreen() =>
      cupertinoRoute(RouteName.profileScreen, (ctx) => ProfileScreen());

  static Route emailScreen() =>
      cupertinoRoute(RouteName.emailScreen, (ctx) => EmailScreen());

  static Route otpScreen() =>
      cupertinoRoute(RouteName.otpScreen, (ctx) => OTPScreen());
}
