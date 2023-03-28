import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/events/eventCard.dart';
import 'package:zineapp2023/screens/events/view_models/events_vm.dart';
import 'package:zineapp2023/theme/color.dart';

class Events extends StatelessWidget {
  const Events({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventsVm>(builder: (context, eventsVm, _) {
      eventsVm.getAllEvents();
      var events = eventsVm.events;
      return Scaffold(
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height*0.1,
          elevation: 0,
          centerTitle: true,
          backgroundColor: backgroundGrey,
          leading: GestureDetector(
            onTap: () => {Navigator.pop(context)},
            child: Image.asset(
              "assets/images/backbtn.png",
              height: 30,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "EVENT",
            style: TextStyle(
              height: 0.9,
              letterSpacing: 0.3,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(225, 34, 33, 33),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: backgroundGrey,
          ),
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < events.length; i++)
                    EventCard(event: events[i])
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
