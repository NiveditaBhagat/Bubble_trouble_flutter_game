import 'package:flutter/material.dart';


class Mybutton extends StatelessWidget {
  final icon;
  final function;
   Mybutton({this.icon, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          
          color: Colors.grey[100],
          width:50,
          height: 50,
          child:Center(child: Icon(icon),),
        ),
      ),
    );
  }
}