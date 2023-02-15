import 'package:flutter/material.dart';

class MyMissile extends StatelessWidget {
  final missileX;
  final height;
  const MyMissile({this.height,this.missileX});

  @override
  Widget build(BuildContext context) {
    return Container(
                    alignment: AlignmentDirectional(missileX, 1),
                    child: Container(
                      width: 2,
                      height: height,
                      color: Colors.grey,
                    ),
                  );
  }
}