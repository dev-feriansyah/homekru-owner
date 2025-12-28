import 'package:flutter/material.dart';

class CreateHouseholdProvider extends ChangeNotifier{

  List<String> _houseHoldType = ["abc", "xyz", "pqr"];
  List<String> get houseHoldType => _houseHoldType;

   List<String> _noOfResidentsList = ["1","2","3","4","5"];
  List<String> get noOfResidentsList => _noOfResidentsList;

   String _houseHoldTypeValue = "";
  String get houseHoldTypeValue => _houseHoldTypeValue;

  String _noOfResidentsValue = "";
  String get noOfResidentsValue => _noOfResidentsValue;

  bool _createNewHousehold = true;
  bool get createNewHousehold => _createNewHousehold;

  bool _createCoOwner = false;
  bool get createCoOwner => _createCoOwner;


 void  selectHouseHoldType(val){
  _houseHoldTypeValue = val;
  notifyListeners();
  }


  void  selectnoOfResidents(val){
  _noOfResidentsValue = val;
  notifyListeners();
  }
}