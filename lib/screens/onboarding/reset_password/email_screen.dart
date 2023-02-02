import 'package:flutter/material.dart';

import '../../../common/routing.dart';
import '../../../components/gradient.dart';
import '../../../theme/color.dart';

class EmailScreen extends StatelessWidget {
  EmailScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:true,
      backgroundColor: backgroundGrey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height * 0.22,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.0))),
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 40.0),
          decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25.0)),
              gradient: mainGrad //need to replace with made component
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              //White Circle Size
              Align(
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: 42.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    //Zine Logo Size
                    radius: 34.0,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/zine_logo.png'),
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Robotics\nand\nResearch\nGroup",
                  style: TextStyle(
                      fontFamily: 'Poppins-ExtraBold',
                      height: 0.9,
                      letterSpacing: 0.3,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            children: [
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "Forgot Password ?",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text("We will send a OTP on the registered email address",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 15.0,
                  )),
              const SizedBox(
                height: 25.0,
              ),
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email address",
                          style: TextStyle(color: greyText, fontSize: 16.0),
                        ),
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                          ),
                          textInputAction: TextInputAction.done,
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
                        const SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Send",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: greyText,
                                fontSize: 25.0
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async{
                                await Navigator.of(context).push(Routes.otpScreen());
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 50.0)),
                                backgroundColor:
                                    MaterialStateProperty.all(textColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_rounded
                              )
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
