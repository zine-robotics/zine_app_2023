import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

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
          )),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: const [
                      CircleAvatar(
                        radius: 50.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/images/zine_logo.png'),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Robotics\nand\nResearch\nGroup",
                        style: TextStyle(
                            height: 0.9,
                            letterSpacing: 0.3,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Text(
                    'DESIGN.\nCREATE.\nINNOVATE.\n',
                    style: TextStyle(
                      height: 0.9,
                      letterSpacing: 0.3,
                      fontSize: 60.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        TextButton(onPressed: (){}, child: Text("Login")),
                        TextButton(onPressed: (){}, child: Text("Login")),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
