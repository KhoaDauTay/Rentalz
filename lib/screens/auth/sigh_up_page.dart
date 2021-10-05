import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:page_transition/page_transition.dart';

import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _api = API();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: const Image(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      image: AssetImage('asset/images/ava.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: LoginPage(),
                                    type: PageTransitionType.leftToRight));
                          },
                          icon: Icon(FlutterIcons.chevron_left_ent))
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey There!",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontFamily: "Montserrat"),
                      ),
                      Text(
                        "Welcome to the RentalZ",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Montserrat"),
                      ),
                      Text(
                        "Fill in your details",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontFamily: "Montserrat"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: Column(
                      children: [
                        stylishTextField(
                          text: "User Name",
                          textEditingController: userNameController,
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value == '') {
                              return "User name field is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        stylishTextField(
                            text: "Password",
                            textEditingController: passwordController,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Password field is required";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        stylishTextField(
                            text: "Confirm password",
                            textEditingController: password2Controller,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Confirm password must field is required";
                              }
                              if (passwordController.text != value) {
                                return "Confirm password must be same password";
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          const TextSpan(
                              text: "Already have an account ? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              )),
                          TextSpan(
                              text: "Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: LoginPage(),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline)),
                        ])),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () => submitData(context),
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(18)),
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var result = await _api.signUp({
        "username": userNameController.text,
        "password": passwordController.text,
        "password2": password2Controller.text,
        "email": "${userNameController.text}@gmail.com"
      });
      if (result["status"]) {
        final snackBar = SnackBar(
          content: Text(result["message"].toString()),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Timer(
            Duration(
              milliseconds: 500,
            ),
            () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPage();
                })));
      } else {
        final snackBar = SnackBar(
          content: Text(result["message"].toString()),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  stylishTextField(
      {required String text,
      required TextEditingController textEditingController,
      required bool isPassword,
      required String? Function(String?) validator}) {
    return Center(
      child: Container(
        width: 340,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            validator: validator,
            obscureText: isPassword ? true : false,
            enableSuggestions: isPassword ? false : true,
            autocorrect: isPassword ? false : true,
            controller: textEditingController,
            style: const TextStyle(
                color: Colors.black, fontSize: 16.0, fontFamily: "Montserrat"),
            decoration: InputDecoration(
                suffix: IconButton(
                  onPressed: () {
                    textEditingController.clear();
                  },
                  icon: const Icon(
                    FlutterIcons.backspace_mdi,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
                filled: true,
                hintText: text,
                hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(18)))),
          ),
        ),
      ),
    );
  }
}
