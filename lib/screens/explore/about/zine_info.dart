import 'package:flutter/material.dart';
import 'package:zineapp2023/theme/color.dart';

class ZineInfo extends StatelessWidget {
  const ZineInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(30.0),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 35.0,),
            Text(
              "Zine",
              style: TextStyle(
                color: textDarkBlue,
                fontFamily: 'Poppins-Black',
                fontWeight: FontWeight.w900,
                fontSize: 50.0,
                letterSpacing: -2,
                height: 0.3,
              ),
            ),
            Text(
              "Robotics & Research",
              style: TextStyle(
                color: textDarkBlue,
                fontFamily: 'Poppins-Black',
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
                "rem Ipsum on lihtsalt proovitekst, mida kasutatakse printimis- ja ladumistööstuses. "
                "See on olnud tööstuse põhiline proovitekst Lorem Ipsum on lihtsalt proovitekst, "
                "mida kasutatakse printimis- ja ladumistööstuses. See on olnud tööstuse põhiline "
                "proovitekst Lorem Ipsum on lihtsalt proovitekst, mida kasutatakse printimis- ja "
                "ladumistööstuses. See on olnud tööstuse põhiline proovitekst Lorem Ipsum on lihtsalt"
                " proovitekst, mida kasutatakse printimis- ja ladumistööstuses. See on olnud tööstuse"
                " põhiline proovitekst Lorem ",
              style: TextStyle(
                color: textDarkBlue,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 18.0
              ),
            )
          ],
        ),
      ),
    );
  }
}
