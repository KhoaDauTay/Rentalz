import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mobile_final/constants.dart';
import 'package:mobile_final/core/services/api_service.dart';
import 'package:mobile_final/models/user_model.dart';
import 'package:mobile_final/screens/auth/sigh_up_page.dart';
import 'package:mobile_final/screens/admin/admin_home_page.dart';
import 'package:mobile_final/screens/client/client_bottom_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();

  final passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();

  final _api = API();

  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? kSpaceM : kSpaceS;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingM),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: space * 2,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image(
                      width: (height.toInt() / 8),
                      height: (height.toInt() / 8),
                      fit: BoxFit.cover,
                      image: AssetImage('asset/images/ava.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: space,
                ),
                SizedBox(
                  height: space * 2,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Let's sign you in",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontFamily: "Montserrat"),
                      ),
                      Text(
                        "Welcome back",
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
                  height: space * 2.5,
                ),
                Container(
                  child: Form(
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
                          height: space,
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
                          height: space,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: space * 2,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "New member, create account here? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              )),
                          TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: SignUpPage(),
                                          type:
                                              PageTransitionType.rightToLeft));
                                },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline)),
                        ])),
                        SizedBox(
                          height: space,
                        ),
                        TextButton(
                          onPressed: () => submitData(context),
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(18)),
                            child: Center(
                              child: Text(
                                "Login",
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void submitData(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      showLoaderDialog(context);
      var result = await _api.login({
        "username": userNameController.text,
        "password": passwordController.text,
      });
      if (result["status"]) {
        Navigator.pop(context);
        User user = result["user"];
        if (user.is_superuser) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminPage();
          }));
        } else {
          await storage.write(
              key: "bookmark", value: user.book_marks.toString());
          await storage.write(key: "user_id", value: user.id.toString());
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ClientBottomBar();
          }));
        }
      } else {
        Navigator.pop(context);
        _showMyDialog(context, result["message"]);
      }
    }
  }

  Future<void> _showMyDialog(context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login status:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
