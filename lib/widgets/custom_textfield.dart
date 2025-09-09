import 'package:chatapp/widgets/custom_const.dart';
import 'package:flutter/material.dart';

class CustomformTextfield extends StatelessWidget {
  CustomformTextfield({
    super.key,
    required this.label,
    required this.hint,
    this.onChanged,
     this.obscureText=false,
  });
  bool ? obscureText;
  final String label;
  final String hint;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
    color: Colors.white, 
    fontSize: 18,      
    fontWeight: FontWeight.bold, 
  ),
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return "field is requird";
        }

      },
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(),
        label: Text(label, style: TextStyle(color: Colors.white, fontSize: 25)),
        hint: Text(hint, style: TextStyle(color: Colors.amber)),
      ),
    );
  }
}
