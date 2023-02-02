import 'package:flutter/material.dart';

import '../../../theme/color.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  // String? _password;
  //
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height * 0.25,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 50.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 160.0,
                child: Image.asset(
                  'assets/images/zine_logo.png',
                ),
              ),
              const Positioned(
                bottom: 10,
                child: Text(
                  "Robotics And Research Group",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(35.0))),
      ),
      backgroundColor: backgroundGrey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Reset Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),

                const Text(
                  "New Password",
                  style: TextStyle(color: greyText, fontSize: 18.0),
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                  obscureText: _passwordVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: const Text(
                      "•••••",
                      style: TextStyle(color: Color(0xffD9D9D9)),
                    ),
                    suffixIcon: IconButton(
                      icon: ImageIcon(
                        const AssetImage('assets/icons/eye.png'),
                        color: _passwordVisible ? greyText : Colors.black,
                      ),
                      onPressed: _toggle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(color: greyText, fontSize: 18.0),
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                  obscureText: _passwordVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: const Text(
                      "•••••",
                      style: TextStyle(color: Color(0xffD9D9D9)),
                    ),
                    suffixIcon: IconButton(
                      icon: ImageIcon(
                        const AssetImage('assets/icons/eye.png'),
                        color: _passwordVisible ? greyText : Colors.black,
                      ),
                      onPressed: _toggle,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),
                //Error Text In case of error returning from the Server
                const Text(
                  "",
                ),
                const SizedBox(
                  height: 25.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20.0)),
                    backgroundColor: MaterialStateProperty.all(textColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
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

