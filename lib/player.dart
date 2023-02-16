import 'package:flutter/material.dart';


class MyPlayer extends StatelessWidget {

  final playerX;
  const MyPlayer({this.playerX});

  @override
  Widget build(BuildContext context) {
    return Container(
    alignment: Alignment(playerX, 1),
       child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
         child: Container(
            height:120,
            width: 120,
           decoration: BoxDecoration(
            
            image: DecorationImage(image: AssetImage('assets/images/bubble.png'),fit: BoxFit.cover),
           ),
          ),
       ),
        );
    }
}