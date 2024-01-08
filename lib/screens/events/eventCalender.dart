import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';
import 'package:zineapp2023/screens/home/home_screen.dart';
import 'package:zineapp2023/utilities/DateTime.dart';
import '../../common/routing.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:intl/intl.dart';
import '../../models/user.dart';
import '../../providers/user_info.dart';
import '../dashboard/view_models/dashboard_vm.dart';
import '../home/home_screen.dart';
import 'eventResuableWid.dart';


class EventCalender extends StatefulWidget {
  const EventCalender({super.key});

  @override
  State<EventCalender> createState() => _EventCalenderState();
}

/*class WorkshopProvider extends ChangeNotifier {
  String _name = 'undefined michi 😼';

  String get name => _name;

  set name (String newName) {
    _name = newName;
    notifyListeners();
  }*/




class _EventCalenderState extends State<EventCalender> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();
  var isExpanded = false;
  int _currentIndex=0;
  int index=-1;


  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Consumer2<DashboardVm, UserProv>(
        builder: (context, dashboardVm, userProv, _) {
       dashboardVm.getRecentEvent();

       var eventsDate=  dashboardVm.getEventDate();

      //var EventsDate=dashboardVm.getEventDate();
      UserModel currUser = userProv.getUserInfo();

      String month = DateFormat.MMMM().format(DateTime.now()).toUpperCase();
      print("month is :$month");

      return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundGrey,
        leading: GestureDetector(
          onTap: () => {Navigator.pop(context)},
          child: Image.asset(
            "assets/images/backbtn.png",
            height: 20,

          ),
        ),
        title: const Text(
          "CALENDAR",
          style: TextStyle(
            height: 0.9,
            fontSize: 23,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
            color: Colors.grey,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Container(

                width: MediaQuery.of(context).size.width * 0.9,
                height: 349,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "th            ",
                      style:
                      TextStyle(color: Color.fromARGB(255, 12, 113, 176)),
                    ),
                    Text(
                      "${DateTime.now().day}   ${DateFormat('MMM').format(DateTime.now()).toUpperCase()}  ",
                      style: TextStyle(
                          height: 0.9,
                          letterSpacing: 0.3,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 12, 113, 176)),
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 28.0,top: 0.0,bottom: 0.0),
                      child: TableCalendar(

                        focusedDay: today,
                        headerVisible: true,

                        headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronVisible: true,
                            rightChevronVisible: true,


                           ),
                        availableGestures: AvailableGestures.horizontalSwipe,

                        selectedDayPredicate: (day) =>
                        isSameDay(day, today) || dashboardVm.isHighlightedDay(day),
                        firstDay: DateTime.utc(2024, 1, 1),
                        lastDay: DateTime.utc(2024, 5, 5),
                        onDaySelected: (selectedDay,_) {

                          if (dashboardVm.isHighlightedDay(selectedDay)) {
                            // Navigate to another page when a highlighted date is selected
                            Navigator.of(context).push(Routes.Event(selectedDate: selectedDay));
                          }
                          //Navigator.of(context).push(Routes.chatHome());
                        },
                        rowHeight: 33,
                        daysOfWeekStyle: DaysOfWeekStyle(

                            weekdayStyle: TextStyle(
                                color: Color.fromARGB(255, 12, 113, 176),
                                fontWeight: FontWeight.bold
                            ),
                            weekendStyle: TextStyle(
                                color: Color.fromARGB(255, 12, 113, 176),
                                fontWeight: FontWeight.bold
                            )
                        ),
                        calendarBuilders: CalendarBuilders(),
                        calendarStyle: CalendarStyle(
                          tableBorder: TableBorder.all(color: Colors.transparent),
                          outsideDaysVisible: false,
                          markerSize: 50,
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 12, 113, 176),
                            //borderRadius: BorderRadius.circular(8)
                          ),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(0),
                            color: Color.fromARGB(255, 12, 113, 176),
                            border: Border.all(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => {
                //it is for blogs
                Navigator.of(context).push(Routes.chatHome())

              },
              child: eventContainer(text1:"TASK" ,text2:userProv.currUser.tasks!.length.toString() ),
            ),
            //it is for workshop
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () => {
                //it is for blogs
                Navigator.of(context).push(Routes.Event())
                /* Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Event_on_date()))*/
              },
              child: eventContainer(text1: "WORKSHOP",text2: dashboardVm.events.length.toString()),
            ),
            SizedBox(
              height: 10,
            ),

            GestureDetector(
              onTap: () => {
                //it is for blogs

              dashboardVm.launchUrl(
              'https://zine.co.in/blogs')

              },
              child: eventContainer(text1: "BLOGS",text2: "7"),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BottomNavigationBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
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
                    currentIndex: _currentIndex,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    unselectedIconTheme: const IconThemeData(size: 25.0),
                    selectedIconTheme: const IconThemeData(size: 30.0),
                    onTap: (index){
                      switch (index) {
                        case 0:
                          Navigator.of(context).push(Routes.chatHome());
                          break;
                        case 1:
                          Navigator.of(context).push(Routes.exploreScreen());
                          break;
                        case 2:
                          Navigator.of(context).pushReplacement(Routes.homeScreen());
                          break;
                      }

                    },
                  ),
                ),
              ),
            ),*/



          ],
        ),
      ),
    );
  });
}}


//Resuable widget

