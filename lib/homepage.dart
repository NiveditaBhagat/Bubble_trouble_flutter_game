import 'dart:async';

import 'package:bubble_trouble/button.dart';
import 'package:bubble_trouble/missile.dart';
import 'package:bubble_trouble/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  static double playerX=0.0; 
 double missileX=playerX;
 double missileHeight=10;

 void moveLeft(){
  setState(() {
  
    if(playerX-0.1<-1){
      //do nothing
    }else{
       playerX-=0.1;
    }
    missileX=playerX;
  });
 }
 void moveRight(){
  
setState(() {
  if(playerX+0.1>1){
  //do nothing
  }else{
   playerX+=0.1;
  }
 missileX=playerX;
});
 }

 void fireMissile(){
  Timer.periodic(Duration(milliseconds: 20), (timer) { 
    setState(() {
      if(missileHeight>MediaQuery.of(context).size.height*3/4){
        resetMissile();
         timer.cancel();
      }else{
         missileHeight+=10;
      }
     
    });
  });
 }
 
 void resetMissile(){
  missileX=playerX;
  missileHeight=10;
 }



  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
        if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
          moveLeft();
        }else if(event.isKeyPressed(LogicalKeyboardKey.altRight)){
          moveRight();
      }
       
       if(event.isKeyPressed(LogicalKeyboardKey.space)){
        fireMissile();
       }


      },
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink[100],
               child: Stack(
                children: <Widget>[
                    MyMissile(height: missileHeight, missileX: missileX),
                  MyPlayer(playerX: playerX,),
                
                ],
               ),
            ),
            ),
          Expanded(
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Mybutton(icon: Icons.arrow_back,function: moveLeft,),
                  Mybutton(icon: Icons.arrow_upward,function: fireMissile,),
                  Mybutton(icon: Icons.arrow_forward, function: moveRight,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}