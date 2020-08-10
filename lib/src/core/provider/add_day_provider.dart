import 'package:flutter/cupertino.dart';
import 'package:ms_app_round3/src/core/models/eatsDay.dart';

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

  TextEditingController _priceTextController=TextEditingController();
  TextEditingController get priceTextController => _priceTextController;
  set priceTextController(TextEditingController value) {
    _priceTextController = value;
    notifyListeners();
  }



}
