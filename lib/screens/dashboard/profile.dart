import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/components/gradient.dart';
import 'package:zineapp2023/models/user.dart';
import 'package:zineapp2023/providers/user_info.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/register_auth_vm.dart';
import 'package:zineapp2023/screens/onboarding/repo/auth_repo.dart';
import 'package:zineapp2023/theme/color.dart';
import 'package:zineapp2023/utilities/string_formatters.dart';

import '../../common/routing.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<RegisterAuthViewModel, UserProv>(
        builder: (context, regVm, userProv, _) {
      final AuthRepo _authRepo = AuthRepo(store: regVm.store);
      UserModel currUser = userProv.getUserInfo();
      print(currUser.registered as bool);
      return Scaffold(
        backgroundColor: backgroundGrey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          centerTitle: true,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: textColor,
              fontSize: 25,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          actions: [
            IconButton(
              color: greyText,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
            const SizedBox(
              width: 20.0,
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 550 / 451,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/images/backdrop.png"),
                    ),
                  ),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 28.0, vertical: 52.0),
                    elevation: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: mainGrad,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 65.0,
                                  child: Image.asset(
                                      "assets/images/card_image.png"),
                                ),
                                CircleAvatar(
                                  backgroundColor: iconTile,
                                  backgroundImage: AssetImage(
                                    "assets/images/dp/${currUser.dp}.png",
                                  ),
                                  radius: 45.0,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              currUser.email.toString().id().cardID(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              currUser.name.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "WORKSHOP",
                        style: TextStyle(
                          color: textDarkBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        " : ",
                        style: TextStyle(
                          color: greyText,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        currUser != null ? "REGISTERED" : 'NOT REGISTERED',
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      currUser.name.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff767D81),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "College Email ID",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      currUser.email.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff767D81),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Change Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    await _authRepo.signOut();

                    Navigator.of(context).pushAndRemoveUntil(
                        Routes.landingScreen(), (route) => false);
                  },
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20.0)),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout_sharp,
                        color: textColor,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(
                            color: Color(0xff0c72b0),
                            fontFamily: "Poppins",
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
