import 'package:flutter/material.dart';

import '../../../theme/color.dart';
import '../../components/gradient.dart';

class WorkshopScreen extends StatelessWidget {
  const WorkshopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        title: const Text(
          "Workshop",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: mainGrad //need to replace with made component
              ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.handyman,
            size: 150.0,
            color: greyText,
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            "Coming Soon\n Stay Tuned !",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w900, color: greyText, fontSize: 30.0),
          )
        ],
      ),
    );
  }
}
