import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:zineapp2023/screens/dashboard/dashCalendar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xffefefef),
          ),
          height: double.infinity,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        // SizedBox(
                        //   width: 10.0,
                        // ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text("hi",
                                style: TextStyle(
                                    height: 0.9,
                                    letterSpacing: 0.3,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff646464))),
                            SizedBox(
                              height: 4,
                            ),
                            Text("Priyansh",
                                style: TextStyle(
                                    height: 0.9,
                                    letterSpacing: 0.3,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0C72B0))),
                          ],
                        ),
                        const Spacer(),
                        const CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromARGB(255, 96, 93, 93)),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                    const Text("EVENT",
                        style: TextStyle(
                            height: 0.9,
                            letterSpacing: 0.3,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff8D989F))),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: Color.fromARGB(255, 110, 108, 108),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.0),
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text("WORKSHOP",
                                      style: TextStyle(
                                          height: 0.9,
                                          letterSpacing: 0.3,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xff646464))),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "AEROMODELLING",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff0C72B0)),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      height: 110,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(24.0),
                                            bottomRight: Radius.circular(24.0)),
                                        color: Color(0xff0C72B0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: <Widget>[
                                          const Text(
                                            "16 JAN",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    200, 255, 255, 255)),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "18:00\nVLTC",
                                            style: TextStyle(
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                ],
                              )),
                        ),
                      ],
                    ),
                    CarouselSlider(
                      options: CarouselOptions(height: 200.0),
                      items: ["ALGORITHMS", "BEE", "BME", "AERO", "ICU-MCU"]
                          .map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Container(
                                width: 300.0,
                                height: 200.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: Center(
                                  child: Text(
                                    i,
                                    style: const TextStyle(
                                        height: 0.9,
                                        letterSpacing: 0.3,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff0C72B0)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.45,
                          height: 125.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "5",
                                style: TextStyle(
                                    height: 0.9,
                                    letterSpacing: 0.3,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0C72B0)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Submissions",
                                  style: TextStyle(
                                      height: 0.9,
                                      letterSpacing: 0.3,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffaaaaaa))),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.45,
                          height: 125.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "2",
                                style: TextStyle(
                                    height: 0.9,
                                    letterSpacing: 0.3,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0C72B0)),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Chats",
                                  style: TextStyle(
                                      height: 0.9,
                                      letterSpacing: 0.3,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xffaaaaaa))),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
