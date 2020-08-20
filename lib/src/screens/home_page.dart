import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:ms_app_round3/src/screens/usersPage.dart';
import 'package:ms_app_round3/src/widgets/button.dart';
import 'package:ms_app_round3/src/widgets/money_indicator.dart';
import 'package:provider/provider.dart';

import 'addDay.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    UserProvider _userProvider=Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Maz App"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MoneyIndicator(),
            SizedBox(height: 60,),
            AppButton(function: (){

            },name: "Products",iconData:  Icons.monetization_on,),
            SizedBox(height: 15,),
            AppButton(function: () async {
              await _userProvider.getEatsUsers();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => UsersPage()));
            },name: "Users",iconData:  Icons.account_circle,),
            SizedBox(height: 15,),
            AppButton(function: (){},name: "Days",iconData:  Icons.assignment,),
            SizedBox(height: 15,),
            AppButton(function: ()  {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddDays()));
            },name: "Add Day",iconData:  Icons.comment,),
          ],
        ),
      ),
    );
  }
}
