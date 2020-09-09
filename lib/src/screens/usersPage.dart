import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:ms_app_round3/src/screens/userProfile.dart';
import 'package:ms_app_round3/src/widgets/addButton.dart';
import 'package:ms_app_round3/src/widgets/appBar.dart';
import 'package:ms_app_round3/src/widgets/userItemList.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UsersPageState();
  }
}

class UsersPageState extends State<UsersPage> {
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            AppBarClipper(
              title: "Officers",
            ),
            AddButton(
              function: () {},
            ),
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: ListView.builder(
                itemCount: _userProvider.users.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserItemList(
                    user: _userProvider.users[index],
                    selectedAction: () {
                      _userProvider.selectedUser = _userProvider.users[index];
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfile()));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
