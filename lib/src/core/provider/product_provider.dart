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

  List<Product> get allProducts => _allProducts;

  Product _selectedProduct;

  Product get selectedProduct => _selectedProduct;

  set selectedProduct(Product value) {
    _selectedProduct = value;
    notifyListeners();
  }

  TextEditingController nameTextEditorField = TextEditingController();
  TextEditingController priceTextEditorField = TextEditingController();
  var productTypes = {"Product", "sundries"};
  String selectedType = "Product";

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

  Future<dynamic> addProduct() async {
    Product product = new Product(
        id: "",
        price: priceTextEditorField.text,
        name: nameTextEditorField.text,
        sundries: selectedType == "Product" ? "0" : "1");

    final Map<String, dynamic> body = product.toJson();

    _isLoading = true;
    notifyListeners();
    print('Starting request');

    print(json.encode(body));

    http.Response response = await http.post(Environment.addProduct,
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

  Future<dynamic> updateProductInfo() async {
    Product product = new Product(
        id: _selectedProduct.id,
        price: priceTextEditorField.text,
        name: nameTextEditorField.text,
        sundries: selectedType == "Product" ? "0" : "1");

    final Map<String, dynamic> body = product.toJson();

    _isLoading = true;
    notifyListeners();
    print('Starting request');

    print(json.encode(body));

    http.Response response = await http.post(Environment.updateProductInfo,
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
}
