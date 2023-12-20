import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import '../../models/events.dart';
import '../../theme/color.dart';

class WorkshopTile extends StatelessWidget {
  List<Events> events;
  int i;
  var name = {
    "Aptitute Test": "Aptitude Test",
    "Workshops": [
      {"BME":"bme"},
      {"BEE":"bee"},
      {"ic mcu"},
      {"aeromodelling"},
      {"cyber security"},
      {"machine learning"},
      {"algorithms"}
    ],
    "Projects": "Projects",
    "Technical Screening": "Technical Screening",
    "Group Discussions": "Group Discussion",
    "Interviews": "Interview"
  };
  var title = [];
  var image = [];

  WorkshopTile({required this.events, required this.i, super.key});

  @override
  Widget build(BuildContext context) {
    name.forEach((key, value) {
      title.add(key);
      image.add(value);
    });

    // print(image[i]);
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),
        Text(
          title[i].toString(),
          style: const TextStyle(
              color: textColor, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        Text(
          "Stage ${i + 1}",
          style: const TextStyle(color: greyText, fontSize: 16.0),
        ),
        Timeline.tileBuilder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          builder: TimelineTileBuilder.connected(
            contentsAlign: ContentsAlign.alternating,
            oppositeContentsBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: index % 2 == 0
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    events[index].name!,
                    textAlign:
                        index % 2 == 0 ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    events[index].description!,
                    textAlign:
                        index % 2 == 0 ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                        color: greyText,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                ],
              ),
            ),
            contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: index % 2 == 0
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat.yMMMd()
                          .format(events[index].timeDate!.toDate()),
                      textAlign:
                          index % 2 != 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xff6d93aa),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                    Text(
                      DateFormat.jm().format(events[index].timeDate!.toDate()),
                      textAlign:
                          index % 2 != 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xff6d93aa),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                    Text(
                      events[index].venue!,
                      textAlign:
                          index % 2 != 0 ? TextAlign.right : TextAlign.left,
                      style: const TextStyle(
                          color: Color(0xff6d93aa),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    ),
                  ],
                )),
            connectorBuilder: (context, index, ConnectorType c) =>
                const SolidLineConnector(
              color: Color(0xffAAAAAA),
            ),
            indicatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: iconTile,
                radius: 25.0,
                child: ImageIcon(
                  AssetImage(
                      "assets/images/timeline/${i == 1 ? events[index].name!.toLowerCase() : image[i].toString().toLowerCase()}.png"),
                  color: Colors.black,
                ),
              ),
            ),
            itemCount: events.length,
          ),
        )
      ],
    );
  }
}
