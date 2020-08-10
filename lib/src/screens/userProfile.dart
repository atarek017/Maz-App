import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {
  UserProvider _userProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_userProvider.selectedUser.name),
      ),
    );
  }
}
