import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/dashboard/view_models/dashboard_vm.dart';

class ZineWhiteLogoWidget extends StatelessWidget {
  const ZineWhiteLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardVm>(builder: (context, dashboardVm, _) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 2 - 60,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        dashboardVm.launchUrl(
                            'https://www.instagram.com/zine.robotics/');
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(9.0, 18, 9, 18),
                        child: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        dashboardVm.launchUrl('https://zine.co.in/');
                      },
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(9.0, 18, 20, 18),
                        child: FaIcon(
                          FontAwesomeIcons.globe,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.16,
              // ),
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
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
