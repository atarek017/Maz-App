import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoneyIndicatorState();
  }
}

class MoneyIndicatorState extends State<MoneyIndicator> {

  var money_amount=0;
  var money_founder=0;

  @override
  void initState() {
    sleep1();
    super.initState();
  }

  Future sleep1() async {
    money_amount = await moneyAmount();
    money_founder= await moneyFounder();
    return new Future.delayed(const Duration(seconds: 1));

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularPercentIndicator(
        radius: 130.0,
        animation: true,
        animationDuration: 1200,
        lineWidth: 15.0,
        percent: money_amount/money_founder,
        center: new Text(
          money_amount.toString() +" LE",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        circularStrokeCap: CircularStrokeCap.butt,
        backgroundColor: Colors.greenAccent,
        progressColor: Colors.green,
      ),
    );
  }



  Future<int> moneyAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int moneyAmount =( prefs.getInt('moneyAmount')??0) ;
    return moneyAmount;
  }

  Future<int> moneyFounder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int moneyFounder = (prefs.getInt('moneyFounder') ??1) ;
    return moneyFounder;
  }

}
