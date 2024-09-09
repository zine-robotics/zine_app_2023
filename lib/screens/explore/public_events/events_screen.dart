// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/explore/public_events/event_calendar.dart';
import 'package:zineapp2023/screens/explore/public_events/event_tile.dart';
import 'package:zineapp2023/screens/explore/public_events/view_models/public_events_vm.dart';
import 'package:zineapp2023/theme/color.dart';

class EventsScreen extends StatelessWidget {
  EventsScreen({super.key});

  bool isEven(int index) {
    return index % 2 == 0;
  }

  final ScrollController _controller = ScrollController();

  // final List<Events> dummyEvents = [
  //   Events(
  //       name: 'Big Thing',
  //       description: 'Its Really Big',
  //       venue: 'On the streets baybee',
  //       timeDate: Timestamp.fromDate(DateTime.utc(2024, 7, 18))),
  //   Events(
  //       name: 'Second Big Thing',
  //       description: 'Its Really Small',
  //       venue: 'Not On the streets baybee',
  //       timeDate: Timestamp.fromDate(DateTime.utc(2024, 8, 19))),
  //   Events(
  //       name: 'Thing',
  //       description: 'Its Real',
  //       venue: 'On the baybee',
  //       timeDate: Timestamp.fromDate(DateTime.utc(2024, 9, 20))),
  // ];

  @override
  Widget build(BuildContext context) {
    // var height = MediaQuery.of(context).size.height;
    double availableHeight = MediaQuery.of(context).size.height -
        (kBottomNavigationBarHeight + kToolbarHeight);
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundGrey,
        surfaceTintColor: backgroundGrey,
        //
        // leading: IconButton(
        //   icon: const Icon(
        //     color: greyText,
        //     Icons.arrow_back_rounded,
        //     size: 40,
        //   ),
        //   onPressed: () {
        //     // Navigator.canPop(context);
        //   },
        // ),

        leading: (Navigator.canPop(context))
            ? IconButton(
                icon: const Icon(
                  color: greyText,
                  Icons.arrow_back_rounded,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        title: const Text(
          "UPCOMING EVENTS",
          style: TextStyle(
              height: 0.9,
              letterSpacing: 0.3,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: greyText),
        ),
      ),
      body: Consumer<PublicEventsVM>(
        builder: (context, evm, _) {
          evm.loadEvents();
          if (evm.events.isNotEmpty && _controller.hasClients) {
            _controller.animateTo(evm.selectedIndex * 154,
                curve: Curves.easeInOut, duration: Duration(milliseconds: 250));
          }
          return Column(
            children: [
              Container(
                // height: availableHeight / 2,
                color: backgroundGrey,
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Card(
                    color: Colors.white,
                    child: EventCalendar(
                      evm: evm,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              (evm.events.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                      clipBehavior: Clip.hardEdge,
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                          child: EventTile(
                            evm: evm,
                            index: index,
                            event: evm.events[index],
                          ),
                        );
                      },
                      itemCount: evm.events.length,
                    ))
                  : Expanded(
                      child: Center(
                        child: Text(
                          'SOMETHINGS COOKING',
                          style: TextStyle(
                              height: 0.9,
                              letterSpacing: 0.3,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                              color: greyText),
                        ),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
