
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
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          child: IconButton(
            color: Colors.white,
            onPressed: function,
            icon: Icon(Icons.add_circle_outline),
          ),
        ),
      ),
    );
  }
}