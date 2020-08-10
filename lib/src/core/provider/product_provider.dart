import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ms_app_round3/src/core/models/failedRequest.dart';
import 'package:ms_app_round3/src/core/models/product.dart';
import 'package:http/http.dart' as http;

import '../environment.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Product> _allProducts = [];
  String selectedProductName;

  List<Product> get allProducts => _allProducts;

  Future<dynamic> getAllProducts() async {
    _isLoading = true;
    notifyListeners();
    print('Starting request');

    http.Response response = await http.post(Environment.getAllProducts,
        headers: Environment.requestHeader);
    print('Completed request');
    print(' response : ${response.body}');
    Map<String, dynamic> res = json.decode(response.body);
    var results;
    if (res['code'] == 200) {
      _allProducts = [];
      if (res['data'] != '[]') {
        res['data'].forEach((v) {
          _allProducts.add(new Product.fromJson(v));
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
