import 'package:flutter/material.dart';
import 'package:zineapp2023/screens/explore/zine_logo_widget.dart';

import '../../common/routing.dart';

class Explore extends StatelessWidget {
  const Explore({Key? key}) : super(key: key);

  static const cards = [
    {"name": "Team", "route": "team", "image": "assets/images/team.png"},
    {
      "name": "Achievements",
      "route": "achievement",
      "image": "assets/images/achievements.png"
    },
    {
      "name": "Projects",
      "route": "project",
      "image": "assets/images/projects.png"
    },
    {
      "name": "Workshops",
      "route": "workshop",
      "image": "assets/images/workshop.png"
    },
  ];

  Future<dynamic> routeMe(BuildContext context, String route) async {
    switch (route) {
      case RouteName.teamScreen:
        await Navigator.of(context).push(Routes.teamScreen());
        break;
      case RouteName.aboutMe:
        await Navigator.of(context).push(Routes.aboutMe());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                Color(0xff268CCB),
                Color(0xff003D63),
              ],
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ZineWhiteLogoWidget(),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2 + 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(0),
                          ),
                        ),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(35.0),
                          itemCount: cards.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (BuildContext ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      offset: Offset(
                                        5.0,
                                        15.0,
                                      ),
                                      blurRadius: 20.0,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () =>
                                      routeMe(context, cards[index]["route"]!),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          cards[index]["image"]!,
                                          height: 50,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          cards[index]["name"]!,
                                          style: const TextStyle(fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 2 - 90,
                  right: 30,
                  child: InkWell(
                    onTap: () => routeMe(context, "about"),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Center(
                        child: Text(
                          "i",
                          style: TextStyle(
                            height: 1,
                            letterSpacing: 0.3,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(12, 114, 176, 0.949375),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
