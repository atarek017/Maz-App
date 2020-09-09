import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_app_round3/src/core/provider/mony_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoneyIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoneyIndicatorState();
  }
}

class MoneyIndicatorState extends State<MoneyIndicator> {
  @override
  Widget build(BuildContext context) {
    MoneyProvider _moneyProvider = Provider.of<MoneyProvider>(context);

    return FutureBuilder(
      future: _moneyProvider.getMoney(false),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var percent=  (_moneyProvider.money.founder -_moneyProvider.money.amount-_moneyProvider.money.sundries)/(_moneyProvider.money.founder );
        print("percent "+percent.toString());
        return Center(
          child: CircularPercentIndicator(
            radius: 130.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: percent,
            center: new Text(
              (_moneyProvider.money.founder - _moneyProvider.money.amount-_moneyProvider.money.sundries)
                      .toString() +
                  " LE",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: Colors.lightGreenAccent,
            progressColor: Colors.green[400],
          ),
        );
      },
    );
  }
}
