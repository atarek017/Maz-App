import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ms_app_round3/src/core/models/failedRequest.dart';
import 'package:ms_app_round3/src/core/models/mony.dart';

import '../environment.dart';
import 'package:http/http.dart' as http;

class MoneyProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Money _money = Money(amount: 0, founder: 0,sundries: 0);

  Money get money => _money;

  Future<dynamic> getMoney(bool listen) async {
    _isLoading = true;
    if (listen == true) notifyListeners();
    print('Starting request');

    http.Response response = await http.post(Environment.getMoney,
        headers: Environment.requestHeader);
    print('Completed request');

    print(' response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);

    var results;
    if (res['code'] == 200) {
      if (res['data'] != null) {
        _money = Money.fromJson(res['data']);
      }
      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    if (listen == true) notifyListeners();

    return results;
  }
}
