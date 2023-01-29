import 'package:flutter/material.dart';

import '../../../common/routing.dart';
import '../../../theme/color.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  String? _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Email address",
                style: TextStyle(color: greyText, fontSize: 18.0),
              ),
              TextFormField(
                style: const TextStyle(
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                cursorColor: textColor,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Text(
                    "abc@iiitk/mnit.ac.in",
                    style: TextStyle(color: Color(0xffD9D9D9)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Password",
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
              GestureDetector(
                onTap: () async{
                  await Navigator.of(context).push(Routes.emailScreen());
                },
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
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
                  "Login",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
