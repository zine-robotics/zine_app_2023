import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import '../../models/events.dart';
import '../../theme/color.dart';
import '../events/view_models/events_vm.dart';

class WorkshopTile extends StatelessWidget {
  List<Events> events;

  WorkshopTile({required this.events, super.key});

  @override
  Widget build(BuildContext context) {







    // print(image[i]);
    return Column(
      children: [
        const SizedBox(
          height: 15.0,
        ),

          


          for(int j=0;j<events.length;j++)
            events[j].isHeading=="true"?
              Column(
              children: [

                Text("${events[j].name.toString()}",style: const TextStyle(
                    color: textColor, fontWeight: FontWeight.bold, fontSize: 25.0),),
                Text(
                    "Stage ${events[j].stage.toString()}",
                    style: const TextStyle(color: greyText, fontSize: 16.0)),

              ],
            ):Container(),





       /* Text(
          "Stage ${events[i].stage.toString()}",
          style: const TextStyle(color: greyText, fontSize: 16.0),
        ),*/

        
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
                child:
                /*  AssetImage(
                      "assets/images/timeline/${i == 1 ? events[index].name!.toLowerCase() : image[i].toString().toLowerCase()}.png"),
              */
                  Image.network(events[index].image.toString(),color: Colors.black,width: 35,)
                ,
              ),
            ),
            itemCount: events.length,
          ),
        )
      ],
    );
  }
}
