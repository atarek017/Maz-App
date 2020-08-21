import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/models/product.dart';
import 'package:ms_app_round3/src/core/provider/add_day_provider.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyDialogContent extends StatefulWidget {
  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  UserProvider userProvider;
  AddDayProvider _addDayProvider;


  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    _addDayProvider = Provider.of<AddDayProvider>(context);
    return _getContent();
  }

  _getContent() {
    return userProvider.isLoading == true
        ? Container(
            height: 400,
            color: Colors.grey[350],
            child: Center(child: CircularProgressIndicator()),
          )
        : Container(
            height: 400,
            color: Colors.grey[350],
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 80,
                      child: DropdownButton<String>(
                        items: _addDayProvider.products
                            .map((Product dropDowenItem) {
                          return DropdownMenuItem<String>(
                            value: dropDowenItem.name,
                            child: Text(dropDowenItem.name),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            _addDayProvider.selectedProductName = newValue;
                          });
                        },
                        value:  _addDayProvider.selectedProductName,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 80,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        controller: _addDayProvider.priceTextController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: "Price",
                            hintStyle: TextStyle(
                              fontSize: 13,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: userProvider.allusers.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CheckboxListTile(
                          title: Text(
                              userProvider.allusers[index].name.toString()),
                          onChanged: (bool value) {
                            setState(() {
                              if (value == true) {
                                setState(() {
                                  userProvider.allusers[index].check = value;
                                });

                                _addDayProvider.offersIds
                                    .add(userProvider.allusers[index].id);
                              } else {
                                setState(() {
                                  userProvider.allusers[index].check = value;

                                  _addDayProvider.offersIds.removeWhere(
                                      (item) =>
                                          item ==
                                          _addDayProvider.offersIds[index]);
                                });
                              }
                            });
                          },
                          value: userProvider.allusers[index].check == null
                              ? false
                              : userProvider.allusers[index].check,
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
