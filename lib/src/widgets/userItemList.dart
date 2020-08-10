import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/models/user.dart';

class UserItemList extends StatelessWidget {
  User user;
  Function selectedAction;

  UserItemList({this.user, this.selectedAction});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.grey[300], offset: Offset(-2, 5))
          ]),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
        onTap: selectedAction,
        leading: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          padding: EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundColor: Colors.greenAccent[700],
            backgroundImage: NetworkImage(user.photo),
            maxRadius: 25,
            minRadius: 11,
            child: user.photo == "" || user.photo == null
                ? Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  )
                : Container(),
          ),
        ),
        title: Center(
          child: Text(
            user.name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),
        trailing: Text(
          user.price + " LE",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
