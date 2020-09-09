import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarClipper extends StatelessWidget {
  String title;
  AppBarClipper({this.title});
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _DrawClipper(),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerLeft, colors: [
          Colors.lightGreenAccent,
          Colors.green,
        ])),
        child: Center(
            child: Text(
              title,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        )),
      ),
    );
  }
}

class _DrawClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height - 35);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 35);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
