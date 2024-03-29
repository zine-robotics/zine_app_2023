import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/providers/dictionary.dart';
import 'package:zineapp2023/theme/color.dart';

class MentorInfo extends StatelessWidget {
  const MentorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Language>(builder: (context, dict, _) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            )),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        "assets/images/rajesh_sir.webp",
                        fit: BoxFit.contain,
                      )),
                  const SizedBox(height: 10.0,),
                  const Text("Dr. Rajesh Kumar",style: TextStyle(
                    color: textDarkBlue,
                    fontWeight: FontWeight.w900,
                    fontSize: 25.0
                  ),),
                  const SizedBox(height: 10.0,),

                  Text(dict.aboutScreen.about![1].infoBody!,
                  style: const TextStyle(
                    color: textDarkBlue
                  ),)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
