 import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/constants.dart';
import '../../../screens/onboarding/login/view_models/login_auth_vm.dart';
import '../../../theme/color.dart';
import '../../../common/routing.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginAuthViewModel>(builder: (context, authVm, _) {
      _emailController.text = authVm.email;
      _passwordController.text = authVm.password;

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
                  onChanged: (value) {
                    authVm.setEmail(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email address";}
                    // } else if (!emailReg.hasMatch(authVm.email)) {
                    //   return "Not a valid Email";
                    // }
                    return null;
                  },
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
                  onChanged: (value) => authVm.setPassword(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a password";
                    } else if (value.length < 6) {
                      return "Password is too short";
                    } else if (value.length > 12) {
                      return "Password is too long";
                    }
                    return null;
                  },
                  obscureText: !authVm.passwordVisible,
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
                        color:
                            !authVm.passwordVisible ? greyText : Colors.black,
                      ),
                      onPressed: authVm.toggleVisible,
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
                  height: 45.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await authVm.loginApi(context);
                    }
                  },
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
