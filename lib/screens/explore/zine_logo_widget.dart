import 'package:flutter/material.dart';

class ZineWhiteLogoWidget extends StatelessWidget {
  const ZineWhiteLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2 - 60,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset("assets/images/zine_logo_white.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              " ROBOTICS AND RESEARCH GROUP",
              style: TextStyle(
                height: 1,
                letterSpacing: 0.3,
                fontSize: 17.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
