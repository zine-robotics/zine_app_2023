

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';
import 'package:zineapp2023/screens/home/home_screen.dart';
import 'package:zineapp2023/utilities/date_time.dart';
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





class _EventCalenderState extends State<EventCalender> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();
  var isExpanded = false;
  int index=-1;


  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Consumer2<DashboardVm, UserProv>(
        builder: (context, dashboardVm, userProv, _) {
       dashboardVm.getRecentEvent();

       //var eventsDate=  dashboardVm.getEventDate();

      //var EventsDate=dashboardVm.getEventDate();
      UserModel currUser = userProv.getUserInfo();
       final DateTime highlightedDate = DateTime(2024, 1, 30);

      String month = DateFormat.MMMM().format(DateTime.now()).toUpperCase();
      print("month is :$month");
       final List<NeatCleanCalendarEvent> _eventList = [
         NeatCleanCalendarEvent("",
           startTime: DateTime(2024, 1, 20),
           endTime: DateTime(2024, 1, 28),
           //color: Colors.orange,
           //icon: Icon(Icons.add),
           //wide: false,
         ),
         NeatCleanCalendarEvent("",
           startTime: DateTime(2024, 2, 3),
           endTime: DateTime(2024, 2, 4),
           //color: Colors.orange,
           //icon: Icon(Icons.add),
           //wide: false,
         ),

       ];


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
                height: 330,
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
                      height: 270,
                      width: 320,
                      margin: const EdgeInsets.only(left: 20.0, right: 28.0,top: 0.0,bottom: 0.0),
                      child: Calendar(
                        startOnMonday: true,

                        weekDays: ['MON', 'TUE', 'WED', 'THR', 'FRI', 'SAT', 'SAT'],
                        //eventsList: _eventList,
                        isExpandable: false,
                        eventDoneColor: Color.fromARGB(255, 12, 113, 176),
                        selectedColor: Color.fromARGB(255, 12, 113, 176),
                        selectedTodayColor: Color.fromARGB(255, 2, 103, 176),
                        todayColor: Color.fromARGB(255, 12, 113, 176),
                        eventColor: null,
                        locale: 'en_US',
                        //todayButtonText: 'Heute',
                        hideTodayIcon: true,
                        //events: ,


                        //allDayEventText: 'Ganztägig',
                        //multiDayEndText: 'Ende',
                        hideBottomBar: false,
                        isExpanded: true,
                        expandableDateFormat: 'EEEE, dd. MMMM yyyy',
                        //datePickerType: DatePickerType.date,
                        dayOfWeekStyle: TextStyle(
                            color: Color.fromARGB(255, 2, 103, 176), fontWeight: FontWeight.w800, fontSize: 11),

                    ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 20,
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
          ],
        ),
      ),
    );
  });
}}


//Resuable widget

