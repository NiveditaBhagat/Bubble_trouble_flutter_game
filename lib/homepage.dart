
import 'dart:async';

import 'package:bubble_trouble/ball.dart';
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
enum direction{LEFT, RIGHT}
class _HomePageState extends State<HomePage> {
 
  static double playerX=0.0; 
 double missileX=playerX;
 double missileHeight=10;
 bool midShot=false;
 var ballDirection=direction.LEFT;

 double ballX=0.5;
 double ballY=0.0;
  
 void moveLeft(){
  setState(() {
  
    if(playerX-0.1<-1){
      //do nothing
    }else{
       playerX-=0.1;
    }

    if(!midShot){
       missileX=playerX;
    }
   
  });
 }
 void moveRight(){
  
setState(() {
  if(playerX+0.1>1){
  //do nothing
  }else{
   playerX+=0.1;
  }
if(!midShot){
       missileX=playerX;
    }
});
 }

 void fireMissile(){
  if(midShot==false){
     Timer.periodic(Duration(milliseconds: 20), (timer) {
      midShot=true;

        setState(() {
            missileHeight+=10;
        }); 

      if(missileHeight>MediaQuery.of(context).size.height*3/4){
        resetMissile();
         timer.cancel();
       
         }

         if(ballY>heightToPosition(missileHeight)&&(ballX-missileX).abs()<0.03){
          resetMissile();
          ballY=5;
          timer.cancel();
         }
    });
  } 
}
 
 void resetMissile(){
  missileX=playerX;
  missileHeight=10;
    midShot=false;
 }

void startGame(){
  double time=0;
  double height=0;
  double velocity=60;
 Timer.periodic(Duration(milliseconds: 10), (timer) {
  height=-5*time*time+velocity*time;

  if(height<0){
    time=0;
  }

  setState(() {
    ballY=heightToPosition(height);
  });


  if(ballX-0.05<-1){
    ballDirection=direction.RIGHT;
  }else if(ballX+0.005>1){
   ballDirection=direction.LEFT;
  } 

  if(ballDirection==direction.LEFT){
   setState(() {
    ballX-=0.005;
  });
  }else if(ballDirection==direction.RIGHT){
    setState(() {
    ballX+=0.005;
  });
  }
  if(playerDies()){
    timer.cancel();
    _showDialog();
  }
  time+=0.1;
 });
}

void _showDialog(){
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey,
         title: Center(child: Text("You dead bro",style:TextStyle(color:Colors.white))),
      );
    });
}
//converts height into cordinates
double heightToPosition(double height){
 double totalHeight=MediaQuery.of(context).size.height*3/4;
 double position=1-(2*height/totalHeight);
 return position;
}

bool playerDies(){
  //if the ball position and the player position are the same,then the player dies
 if((ballX-playerX).abs()<0.03&&ballY>0.95){
  return true;
 }else{
  return false;
 }
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
                children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      DefaultTextStyle(style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold), child:   Text('BUBBLE TROUBLE'), ), 
                      SizedBox(height: 40),
                       DefaultTextStyle(style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold), child:   Text('FLUTTER'), ),
                      
                    ],
                  ),
                ),
                  MyBall(ballX: ballX, ballY: ballY),
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
                  Mybutton(icon: Icons.play_arrow,function:startGame),
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