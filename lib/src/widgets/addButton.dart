import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  Function function;

  AddButton({this.function});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: function,
        child: Container(
          width: 60,
          height: 60,

          decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.5,
                colors: [
                  Colors.lightGreenAccent,
                  Colors.green,
                ],
              ),
              borderRadius: BorderRadius.circular(30),border:Border.all(width: 2,color: Colors.white,) ),

          margin: EdgeInsets.all(16),
          child: Center(
            child: Icon(
              Icons.add_circle_outline,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
