import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/common/loaderScreen.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/login_auth_vm.dart';
import 'package:zineapp2023/screens/onboarding/login/view_models/register_auth_vm.dart';
import './register_form.dart';
import '../../../theme/color.dart';
import './login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginAuthViewModel, RegisterAuthViewModel>(
        builder: (context, logAuthVm, regAuthVm, _) {
      return logAuthVm.loading || regAuthVm.loading
          ? const Loader()
          : DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 250.0,
                  elevation: 0,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 100.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: SizedBox(
                              height: 190.0,
                              child: Image.asset(
                                'assets/images/zine_logo.png',
                              )),
                        ),
                        const Positioned(
                            bottom: 12.0,
                            child: Text(
                              "Robotics And Research Group",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ))
                      ],
                    ),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(35.0))),
                  bottom: const TabBar(
                    indicatorColor: textColor,
                    indicatorWeight: 4.0,
                    labelStyle:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    unselectedLabelStyle: TextStyle(fontSize: 20.0),
                    labelColor: textColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
                    tabs: [
                      Tab(text: 'Login'),
                      Tab(text: 'Sign-Up'),
                    ],
                  ),
                ),
                backgroundColor: backgroundGrey,
                body: TabBarView(
                  children: [
                    LoginForm(),
                    RegisterForm(),
                  ],
                ),
              ),
            );
    });
  }
}
