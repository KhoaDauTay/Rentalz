import 'package:flutter/material.dart';

class MyFormTextField extends StatelessWidget {
  Function(String?) onSaved;
  InputDecoration decoration;
  String? Function(String?) validator;
  void Function(String)? onChanged;
  final bool isObscure;

  MyFormTextField(
      {required this.onSaved,
      required this.decoration,
      required this.isObscure,
      required this.validator,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      obscureText: isObscure,
      decoration: decoration,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
