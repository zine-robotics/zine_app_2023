import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './../view_models/auth_vm.dart';
import '../../../theme/color.dart';

import '../../../common/routing.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    bool _passwordVisible = false;

    String? _password;

    void _toggle() {
      _passwordVisible = !_passwordVisible;
    }

    return Consumer<AuthViewModel>(builder: (context, authVm, _) {
      void validateSubmit() {
        print("validate submit");
        if (_emailController.text.isEmpty) {
          print("email empty");
          // Utils.flushBarErrorMessage('Please enter email', context);
        } else if (_passwordController.text.isEmpty) {
          // Utils.flushBarErrorMessage('Please enter password', context);

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

          authVm.loginApi(data, context);
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
                  "Email address",
                  style: TextStyle(color: greyText, fontSize: 18.0),
                ),

                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),
                  controller: _emailController,
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
                  controller: _passwordController,
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
                  height: 20.0,
                ),
                GestureDetector(
                  onTap: () async {
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
                  onPressed: validateSubmit,
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
                    "Login",
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
