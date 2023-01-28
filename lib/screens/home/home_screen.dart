import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/chat/chat_home.dart';
import 'package:zineapp2023/screens/dashboard/dashboard.dart';
import '../explore/explore.dart';
import 'view_models/home_view_model.dart';
import '../../theme/color.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const List<Widget> _widgetOptions = <Widget>[
    ChatHome(),
    Explore(),
    Dashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeVm>(builder: (context, homeVm, _) {
      return Scaffold(
        body: _widgetOptions.elementAt(homeVm.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: backgroundGrey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.solidMessage,
                size: 20,
              ),
              activeIcon: DecoratedIcon(
                FontAwesomeIcons.solidMessage,
                size: 22,
                color: textColor,
                shadows: [
                  BoxShadow(
                    blurRadius: 42.0,
                    color: blurBlue,
                  ),
                ],
              ),
              label: 'Timeline',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              activeIcon: DecoratedIcon(
                Icons.home,
                color: textColor,
                shadows: [
                  BoxShadow(
                    blurRadius: 42.0,
                    color: blurBlue,
                  ),
                ],
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              activeIcon: DecoratedIcon(
                Icons.account_circle,
                color: textColor,
                shadows: [
                  BoxShadow(
                    blurRadius: 42.0,
                    color: blurBlue,
                  ),
                ],
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: homeVm.selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // selectedItemColor: textColor,
          unselectedIconTheme: const IconThemeData(size: 25.0),
          selectedIconTheme: const IconThemeData(size: 30.0),
          onTap: homeVm.onItemTapped,
        ),
      );
    });
  }
}
