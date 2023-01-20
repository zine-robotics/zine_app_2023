import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zineapp2023/screens/onboarding/view_models/auth_vm.dart';

import '../../theme/color.dart';

class RegisterForm extends StatelessWidget {
  // const RegisterForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;

  String? _password;

  // Toggles the password show status
  void _toggle() {
    _passwordVisible = !_passwordVisible;
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(builder: (context, authVm, _) {
      void validateSubmit() {
        print("validate submit");
        if (_emailController.text.isEmpty) {
          print("email empty");
          // Utils.flushBarErrorMessage('Please enter email', context);
        } else if (_passwordController.text.isEmpty) {
          // Utils.flushBarErrorMessage('Please enter password', context);

        } else if (_passwordController.text != _confirmController.text) {
        } else if (_passwordController.text.length < 6) {
          // Utils.flushBarErrorMessage('Please enter 6 digit password', context);

        } else {
          Map data = {
            'email': _emailController.text.toString(),
            'password': _passwordController.text.toString(),
          };

          // Map data = {
          //   'email' : 'eve.holt@reqres.in',
          //   'password' : 'cityslicka',
          // };

          authVm.signUpApi(data, context);
        }
      }

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
                  "Name",
                  style: TextStyle(color: greyText, fontSize: 15.0),
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  cursorColor: textColor,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: Text(
                      "Anakin Skywalker",
                      style: TextStyle(color: Color(0xffD9D9D9)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "Email address",
                  style: TextStyle(color: greyText, fontSize: 15.0),
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
                  height: 15.0,
                ),
                const Text(
                  "Password",
                  style: TextStyle(color: greyText, fontSize: 15.0),
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                  obscureText: _passwordVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
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
                  height: 15.0,
                ),
                const Text(
                  "Confirm Password",
                  style: TextStyle(color: greyText, fontSize: 15.0),
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                  obscureText: _passwordVisible,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
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
                  height: 15.0,
                ),
                //Error Text In case of error returning from the Server
                const Text(
                  "",
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20.0)),
                    backgroundColor: MaterialStateProperty.all(textColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Sign-Up",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
