import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/models/eatsDay.dart';
import 'package:ms_app_round3/src/core/models/product.dart';
import 'package:ms_app_round3/src/core/provider/add_day_provider.dart';
import 'package:ms_app_round3/src/core/provider/product_provider.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:ms_app_round3/src/widgets/addButton.dart';
import 'package:ms_app_round3/src/widgets/buildDateRow.dart';
import 'package:ms_app_round3/src/widgets/button.dart';
import 'package:ms_app_round3/src/widgets/usersListDialog.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class AddDays extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddDaysState();
  }
}

class _AddDaysState extends State<AddDays> {
  DateTime dateNow = DateTime.now();

  UserProvider _userProvider;
  ProductProvider _productProvider;
  AddDayProvider _addDayProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _productProvider = Provider.of<ProductProvider>(context);
    _addDayProvider = Provider.of<AddDayProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Day"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              BuildDateRow(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: height * .75,
                child: ListView.builder(
                    itemCount: _addDayProvider.eatsDayList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Text(_addDayProvider.eatsDayList[index].productId),
                      );
                    }),
              )
            ],
          ),
          _addDayProvider.eatsDayList.length > 0
              ? Positioned(
                  bottom: 10,
                  left: width * .2,
                  child: AppButton(
                    name: "Add Day",
                    iconData: Icons.add_circle,
                    function: () {


                      final Map<String, dynamic> data = new Map<String, dynamic>();

                      data['svcItems'] =
                          _addDayProvider.eatsDayList.map((v) => v.toJson()).toList();

                      print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
                      print(data);

                    },
                  ),
                )
              : Container(),
          AddButton(
            function: () async {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showDialog();
              });
              await _userProvider.getAllUsers();
              await _productProvider.getAllProducts();
            },
          )
        ],
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return new CupertinoAlertDialog(
          title: new Text('Please Enter Data'),
          actions: <Widget>[
            new CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                setState(() {
                  _addDayProvider.eatsDayList.add(
                    EatsDay(
                      date: _addDayProvider.dateNow.toString(),
                      officerIds: _addDayProvider.offersIds,
                      price: _addDayProvider.priceTextController.text,
                      productId: getProductId(),
                    ),
                  );

                  _addDayProvider.offersIds=[];
                });

                Navigator.of(context).pop('Done');
              },
              child: new Text('Done'),
            ),
          ],
          content: new SingleChildScrollView(
            child: new Material(
              child: new MyDialogContent(),
            ),
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  String getProductId() {
    for (Product i in _productProvider.allProducts) {
      if (i.name == _productProvider.selectedProductName) {
        return i.id;
      }
    }
    return "";
  }
}
