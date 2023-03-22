import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:zineapp2023/models/events.dart';
import 'package:zineapp2023/utilities/DateTime.dart';

class EventCard extends StatefulWidget {
  final Events event;

  const EventCard({Key? key, required this.event}) : super(key: key);
  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Events event = widget.event;
    var isOld =
        Timestamp.fromDate(DateTime.now()).compareTo(widget.event.timeDate!) > 0
            ? false
            : true;
    const textStyleC = TextStyle(
        fontSize: 15,
        color: Color.fromARGB(255, 147, 146, 146),
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
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ExpansionTileCard(
          contentPadding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
          trailing: !isExpanded
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 114, 176, 242),
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(15))),
                )
              : SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          leading: !isExpanded
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      color: isOld
                          ? Color.fromARGB(255, 194, 255, 244)
                          : Colors.grey,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(15))),
                )
              : SizedBox(width: MediaQuery.of(context).size.width * 0.1),
          initialPadding: EdgeInsets.zero,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          baseColor: Color.fromARGB(255, 255, 255, 255),
          expandedColor: Color.fromARGB(255, 12, 113, 176),
          onExpansionChanged: (value) => {isExpanded = value},
          key: cardA,
          // leading: CircleAvatar(child: Image.asset("assets/images/devs.jpg")),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                event.name.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: isExpanded
                        ? Colors.white
                        : Color.fromARGB(255, 12, 113, 176),
                    fontWeight: FontWeight.w700),
              ),
              !isExpanded
                  ? SizedBox(
                      height: 10,
                    )
                  : Container(),
              if (!isExpanded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      getDate(event.timeDate as Timestamp),
                      textAlign: TextAlign.center,
                      style: textStyle3,
                    ),
                    Spacer(),
                    Text(
                      getTime(event.timeDate as Timestamp),
                      textAlign: TextAlign.center,
                      style: textStyle3,
                    ),
                    Spacer(),
                    Text(
                      event.venue.toString(),
                      textAlign: TextAlign.center,
                      style: textStyle3,
                    ),
                    Spacer(),
                  ],
                ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          // subtitle: Text("FLUTTER DEVELOPMENT COMPANY"),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  gradient: LinearGradient(begin: Alignment.centerLeft, stops: [
                    0.01,
                    0.97
                  ], colors: [
                    Color.fromARGB(255, 194, 255, 244),
                    Colors.white.withOpacity(1)
                  ])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DATE",
                            textAlign: TextAlign.left,
                            style: textStyleC,
                          ),
                          Text(
                            textAlign: TextAlign.left,
                            "TIME",
                            style: textStyleC,
                          ),
                          Text(
                            textAlign: TextAlign.left,
                            "VENUE",
                            style: textStyleC,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getDate(event.timeDate as Timestamp),
                            textAlign: TextAlign.center,
                            style: textStyleC2,
                          ),
                          Text(
                            getTime(event.timeDate as Timestamp),
                            textAlign: TextAlign.center,
                            style: textStyleC2,
                          ),
                          Text(
                            event.venue.toString(),
                            textAlign: TextAlign.center,
                            style: textStyleC2,
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 150,
                        child: Text(
                          event.description.toString(),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
    );
  }
}
