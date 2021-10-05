import 'package:flutter/material.dart';

class FormSubmitButton extends StatelessWidget {
  final Function() onPressed;
  FormSubmitButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text('Submit'),
        ),
        width: double.infinity);
  }
}
