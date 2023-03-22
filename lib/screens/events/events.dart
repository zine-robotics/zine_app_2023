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
          body: Center(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: Image.asset(
                            "assets/images/backbtn.png",
                            height: 30,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                          child: Text("EVENT",
                              style: TextStyle(
                                  height: 0.9,
                                  letterSpacing: 0.3,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromARGB(225, 34, 33, 33))),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    for (int i = 0; i < events.length; i++)
                      EventCard(event: events[i])

                    // ? EventCard(
                    //     event: events[0],
                    //   )
                    // : Container()
                    // ListView.builder(
                    //   itemCount: events.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Text("data");
                    //   },
                    // )
                  ],
                )))),
          )));
    });
  }
}
