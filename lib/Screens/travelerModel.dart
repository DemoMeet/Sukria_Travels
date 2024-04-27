import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class travellerModel {
  TextEditingController name, ticketnumber, price;
  String? type;

  travellerModel(
      {required this.type,
      required this.name,
      required this.price,
      required this.ticketnumber});
}
