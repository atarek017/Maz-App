import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ms_app_round3/src/core/models/eatsDay.dart';
import 'package:http/http.dart' as http;
import 'package:ms_app_round3/src/core/models/failedRequest.dart';
import 'package:ms_app_round3/src/core/models/product.dart';

import '../environment.dart';

class AddDayProvider with ChangeNotifier {
  DateTime _dateNow = DateTime.now();

  DateTime get dateNow => _dateNow;

  set dateNow(DateTime value) {
    _dateNow = value;
    notifyListeners();
  }

  List<String> _offersIds = [];

  List<String> get offersIds => _offersIds;

  set offersIds(List<String> value) {
    _offersIds = value;
    notifyListeners();
  }

  List<EatsDay> _eatsDayList = [];

  List<EatsDay> get eatsDayList => _eatsDayList;

  set eatsDayList(List<EatsDay> value) {
    _eatsDayList = value;
    notifyListeners();
  }

  TextEditingController _priceTextController = TextEditingController();

  TextEditingController get priceTextController => _priceTextController;

  set priceTextController(TextEditingController value) {
    _priceTextController = value;
    notifyListeners();
  }



  List<Product> _products = [];
  String selectedProductName;

  List<Product> get products => _products;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<dynamic> addDay() async {
    final List<Map<String, dynamic>> body =
        _eatsDayList.map((v) => v.toJson()).toList();

    _isLoading = true;
    notifyListeners();
    print('Starting request');

    print( json.encode(body));

    http.Response response = await http.post(Environment.addDay,
        body: json.encode(body), headers: Environment.requestHeader);

    print('Completed request');
    print(' response : ${response.body}');

    Map<String, dynamic> res = json.decode(response.body);
    var results;
      if (res['code'] == 200) {

      results = true;
    } else {
      results =
          FailedRequest(code: 400, message: res['message'], status: false);
    }
    _isLoading = false;
    notifyListeners();
    return results;
  }

  Future<dynamic> getProducts() async {
    _isLoading = true;
    notifyListeners();
    print('Starting request');

    http.Response response = await http.post(Environment.getProducts,
        headers: Environment.requestHeader);
    print('Completed request');
    print(' response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      _products = [];
      if (res['data'] != '[]') {
        res['data'].forEach((v) {
          _products.add(new Product.fromJson(v));
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
