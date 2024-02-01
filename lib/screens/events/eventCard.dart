import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:zineapp2023/components/gradient.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/utilities/date_time.dart';

class EventCard extends StatefulWidget {
  final Events event;
  final selectedDate;
  const EventCard({Key? key, required this.event, this.selectedDate})
      : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  var checked = false;
  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final Events event = widget.event;
    // print("date passsing from the eventCalender${widget.selectedDate}");

    bool initExp = false;
    DateTime? date = widget.event.timeDate?.toDate();

    if (widget.selectedDate != null && !checked) {
      print(getDDate(date!));
      print(getDDate(widget.selectedDate));
      initExp = getDDate(date!) == getDDate(widget.selectedDate);
      isExpanded = initExp;
    }
    //isExpanded=int.parse(compareDay.toString())==checkDay ? true :false;

    bool isOld =
        Timestamp.fromDate(DateTime.now()).compareTo(widget.event.timeDate!) > 0
            ? false
            : true;
    var textStyleC = TextStyle(
        fontSize: 15,
        color: !isOld
            ? const Color.fromARGB(255, 12, 113, 176)
            : const Color.fromARGB(255, 147, 146, 146),
        fontWeight: FontWeight.w700);
    const textStyleC2 = TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 0, 61, 99),
        fontWeight: FontWeight.w700);
    const textStyle3 = TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 112, 112, 112),
        fontWeight: FontWeight.w400);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Stack(
        children: [
          ExpansionTileCard(
              initiallyExpanded: initExp,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              trailing:
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              leading: isExpanded
                  ? Container(
                      width: 118,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 113, 176),
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20.0)),
                      ),
                    )
                  : SizedBox(width: MediaQuery.of(context).size.width * 0.1),
              initialPadding: EdgeInsets.zero,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              baseColor: const Color.fromARGB(255, 255, 255, 255),
              expandedColor: const Color.fromARGB(255, 255, 255, 255),
              onExpansionChanged: (value) => {
                    setState(() {
                      isExpanded = value;
                      checked = true;
                    })
                  },
              key: cardA,
              // leading: CircleAvatar(child: Image.asset("assets/images/devs.jpg")),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isExpanded
                      ? Text(
                          event.name.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              color: const Color.fromARGB(255, 12, 113, 176),
                              fontWeight: FontWeight.w800),
                        )
                      : Text(
                          event.name.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.065,
                              color: const Color.fromARGB(255, 12, 113, 176),
                              fontWeight: FontWeight.w800),
                        ),
                  if (!isExpanded)
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        // const Spacer(),
                        //const SizedBox(width: 15,),
                        Text(
                          getDate(event.timeDate as Timestamp),
                          textAlign: TextAlign.center,
                          style: textStyle3,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        // const Spacer(),
                        Text(
                          getTime(event.timeDate as Timestamp),
                          textAlign: TextAlign.center,
                          style: textStyle3,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.055,
                        ),
                        // const Spacer(),
                        Text(
                          event.venue.toString(),
                          textAlign: TextAlign.center,
                          style: textStyle3,
                          softWrap: true,
                        ),
                        //const Spacer(),
                      ],
                    ),
                ],
              ),
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Column(
                        children: [
                          Text(
                            getDay(event.timeDate as Timestamp),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: TextStyle(fontSize: 50, color: Colors.white),
                          ),
                          Text(
                            getDate(event.timeDate as Timestamp),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          Text(getTime(event.timeDate as Timestamp),
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 3, left: 10, bottom: 10),
                            child: Text(
                              event.description.toString(),
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                  ],
                )
              ]),
          isExpanded
              ? Container(
                  height: 210,
                  width: 120,
                  decoration: BoxDecoration(
                    color: date!.compareTo(DateTime.now()) >= 0
                        ? Color.fromARGB(255, 12, 113, 176)
                        : Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        getDay(event.timeDate as Timestamp),
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        getDate(event.timeDate as Timestamp),
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(getTime(event.timeDate as Timestamp),
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(100))),
                      ),
                    ],
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
