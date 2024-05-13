import 'package:flutter/material.dart';

class CheckBoxCustom extends StatefulWidget {
  const CheckBoxCustom({
    super.key,
  });

  @override
  State<CheckBoxCustom> createState() => _CheckBoxCustomState();
}

class _CheckBoxCustomState extends State<CheckBoxCustom> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        checkColor: Colors.white,
        activeColor: Theme.of(context).colorScheme.primary,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}
