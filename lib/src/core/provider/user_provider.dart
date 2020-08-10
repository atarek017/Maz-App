import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:ms_app_round3/src/core/models/failedRequest.dart';
import 'package:ms_app_round3/src/core/models/user.dart';
import '../environment.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<User> _users=[];
  User selectedUser;
  List<User> get users => _users;


  List<User> _allusers=[];
  List<User> get allusers => _allusers;



  Future<dynamic> getEatsUsers() async {
    _isLoading = true;
    notifyListeners();
    print('Starting request');

    http.Response response = await http.post(Environment.getEatsUsers,
        headers: Environment.requestHeader);
    print('Completed request');

    print(' response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      _users = [];
      if (res['data'] != '[]') {
        res['data'].forEach((v) {
          _users.add(new User.fromJson(v));
        });
      }

      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> getAllUsers() async {
    _isLoading = true;
    notifyListeners();
    print('Starting request');

    http.Response response = await http.post(Environment.getAllUsers,
        headers: Environment.requestHeader);
    print('Completed request');

    print(' response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      _allusers = [];
      if (res['data'] != '[]') {
        res['data'].forEach((v) {
          _allusers.add(new User.fromJson(v));
        });
      }

      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }


}
