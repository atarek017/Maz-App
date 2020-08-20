import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ms_app_round3/src/core/provider/add_day_provider.dart';
import 'package:provider/provider.dart';

class BuildDateRow extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _BuildDateRowState();
  }
}

class _BuildDateRowState extends State<BuildDateRow>{

  AddDayProvider addDayProvider;
  @override
  Widget build(BuildContext context) {
    addDayProvider= Provider.of<AddDayProvider>(context);

    var width =MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        showDatePickerBottomSheet(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              Icons.event,
              color: Colors.white,
              size: 20,
            ),
          ),
          SizedBox(width: width*.05),
          Container(
            child: Text(
              DateFormat.yMMMMEEEEd().format(DateTime.parse(addDayProvider.dateNow.toString())),
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }


  Future<bool> showDatePickerBottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          print('date is canceled ');
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 50.0,
                        padding: EdgeInsets.only(
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("done");
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now().add(new Duration(hours: 1)),
                    onDateTimeChanged: (DateTime newDate) async {

                      setState(() {
                        addDayProvider.dateNow = newDate;
                      });
                    },
                    use24hFormat: false,
                    minimumDate: DateTime.now().subtract(Duration(days: 1)),
                    minimumYear: 2019,
                    maximumYear: 2022,
                    minuteInterval: 1,
                    mode: CupertinoDatePickerMode.dateAndTime,
                  ),
                ),
              ),
            ],
          );
        });
  }

}