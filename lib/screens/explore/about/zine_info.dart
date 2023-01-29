import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/theme/color.dart';

class ZineInfo extends StatelessWidget {
  const ZineInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(
      builder: (context,dict,_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35.0,),
                Text(
                  dict.aboutScreen.about![0].infoHead!,
                  style: const TextStyle(
                    color: textDarkBlue,
                    fontFamily: 'Poppins-Black',
                    fontWeight: FontWeight.w900,
                    fontSize: 50.0,
                    letterSpacing: -2,
                    height: 0.3,
                  ),
                ),
                const Text(
                  "Robotics & Research",
                  style: TextStyle(
                    color: textDarkBlue,
                    fontFamily: 'Poppins-Black',
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 20.0,),
                Text(
                  dict.aboutScreen.about![0].infoBody!,
                  style: const TextStyle(
                    color: textDarkBlue,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
