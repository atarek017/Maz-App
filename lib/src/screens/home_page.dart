import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/mony_provider.dart';
import 'package:ms_app_round3/src/core/provider/product_provider.dart';
import 'package:ms_app_round3/src/core/provider/user_provider.dart';
import 'package:ms_app_round3/src/screens/productsPage.dart';
import 'package:ms_app_round3/src/screens/usersPage.dart';
import 'package:ms_app_round3/src/widgets/appBar.dart';
import 'package:ms_app_round3/src/widgets/button.dart';
import 'package:ms_app_round3/src/widgets/money_indicator.dart';
import 'package:provider/provider.dart';

import 'addDay.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  MoneyProvider _moneyProvider;

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    _moneyProvider = Provider.of<MoneyProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            AppBarClipper(
              title: "Maz App",
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: MoneyIndicator(),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  AppButton(
                    function: () async {
                      await _productProvider.getAllProducts();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductsPage()));
                    },
                    name: "Products",
                    iconData: Icons.monetization_on,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    function: () async {
                      await _userProvider.getEatsUsers();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UsersPage()));
                    },
                    name: "Users",
                    iconData: Icons.account_circle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    function: () {},
                    name: "Days",
                    iconData: Icons.assignment,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    function: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddDays()));
                    },
                    name: "Add Day",
                    iconData: Icons.comment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
