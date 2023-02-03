import "package:flutter/material.dart";
import 'dart:math' as math;

import '../../theme/color.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Recent Tasks",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color(0xff8D989F),
            fontSize: 18.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              Transform.rotate(
                angle: math.pi / 50,
                child: const Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    color: Color(0x69D9D9D9),
                    elevation: 0,
                    child: SizedBox(
                      height: 220.0,
                      child: Center(
                        child: Text("Zine Rocks !!!"),
                      ),
                    )),
              ),
              const Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                color: iconTile,
                elevation: 0,
                child: SizedBox(
                  height: 220.0,
                  child: Center(
                    child: Text(
                      "No tasks to show",
                      style: TextStyle(
                          color: backgroundGrey,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                const TabBar(
                    padding: EdgeInsets.all(8.0),
                    indicatorWeight: 0.1,
                    labelColor: blurBlue,
                    labelStyle:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800),
                    unselectedLabelColor: greyText,
                    unselectedLabelStyle:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Text("All Tasks"),
                      Text("Completed"),
                      Text("Incomplete"),
                    ]),
                Expanded(
                  child: TabBarView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 130.0,
                            ),
                            Text(
                              "No Tasks Assigned",
                              style: TextStyle(
                                  color: iconTile,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: const [
                          SizedBox(
                            height: 130.0,
                          ),
                          Text(
                            "No Tasks Assigned",
                            style: TextStyle(
                                color: iconTile,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          SizedBox(
                            height: 130.0,
                          ),
                          Text(
                            "No Tasks Assigned",
                            style: TextStyle(
                                color: iconTile,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
