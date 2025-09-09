import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
   CustomButtom({super.key, required this.namebotoom,this.onTap});
  final String namebotoom;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        child: Center(child: Text(namebotoom, style: TextStyle(fontSize: 20))),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
      ),
    );
  }
}
