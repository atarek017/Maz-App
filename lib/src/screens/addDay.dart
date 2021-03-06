import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/models/eatsDay.dart';
import 'package:ms_app_round3/src/core/models/failedRequest.dart';
import 'package:ms_app_round3/src/core/models/product.dart';
import 'package:ms_app_round3/src/core/provider/add_day_provider.dart';
import 'package:ms_app_round3/src/core/provider/mony_provider.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:ms_app_round3/src/widgets/addButton.dart';
import 'package:ms_app_round3/src/widgets/appBar.dart';
import 'package:ms_app_round3/src/widgets/buildDateRow.dart';
import 'package:ms_app_round3/src/widgets/button.dart';
import 'package:ms_app_round3/src/widgets/dialog.dart';
import 'package:ms_app_round3/src/widgets/usersListDialog.dart';
import 'package:provider/provider.dart';

class AddDays extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddDaysState();
  }
}

class _AddDaysState extends State<AddDays> {
  DateTime dateNow = DateTime.now();

  UserProvider _userProvider;
  AddDayProvider _addDayProvider;
  MoneyProvider _moneyProvider;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _addDayProvider = Provider.of<AddDayProvider>(context);
    _moneyProvider = Provider.of<MoneyProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(

        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                AppBarClipper(
                  title: "Add Day",
                ),

                BuildDateRow(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: height * .74,
                  child: ListView.builder(
                      itemCount: _addDayProvider.eatsDayList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          background: Container(
                            color: Colors.greenAccent,
                          ),
                          key: Key(_addDayProvider.eatsDayList[index].toString()),
                          onDismissed: (direction) {
                            _addDayProvider.eatsDayList.removeAt(index);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Item is Removed"),
                            ));
                          },
                          child: Container(
                            margin:
                                EdgeInsets.only(left: 20, right: 20, bottom: 10),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(getProductName(_addDayProvider
                                    .eatsDayList[index].productId)),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(_addDayProvider.eatsDayList[index].price +
                                    " LE"),
                              ],
                            ),
                          ),
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
                      function: () async {
                        var res = await _addDayProvider.addDay();

                        if (res is FailedRequest) {
                          Dialogs.showErrorDialog(context,
                              message: res.message, code: res.code);
                          print('results ${res.toString()}');
                        } else {
                          Dialogs.showErrorDialog(context,
                              message: "added sucessfuly", code: 200);
                          _addDayProvider.offersIds = [];
                          _addDayProvider.eatsDayList = [];
                          await _moneyProvider.getMoney(true);
                        }
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
                await _addDayProvider.getProducts();
              },
            )
          ],
        ),
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
                  if (_addDayProvider.offersIds.isNotEmpty &&
                      _addDayProvider.priceTextController.text != null) {
                    _addDayProvider.eatsDayList.add(
                      EatsDay(
                        date: _addDayProvider.dateNow.toString(),
                        officerIds: _addDayProvider.offersIds,
                        price: _addDayProvider.priceTextController.text,
                        productId: getProductId(),
                      ),
                    );
                    _addDayProvider.offersIds = [];
                  }
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
    for (Product i in _addDayProvider.products) {
      if (i.name == _addDayProvider.selectedProductName) {
        return i.id;
      }
    }
    return "";
  }

  String getProductName(String id) {
    for (int i = 0; i <= _addDayProvider.products.length; i++) {
      if (_addDayProvider.products[i].id == id)
        return _addDayProvider.products[i].name;
    }
    return "";
  }
}
