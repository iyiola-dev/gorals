import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:gorals/core/models/gorals_model.dart';
import 'package:http/http.dart' as http;

class GoralApi {
  Future<Gorals> getgorals() async {
    try {
      var response =
          await http.get('http://gorals-flutter-test.herokuapp.com/');
      print(response);
      var data = json.decode(response.body);
      print(data);
      var goral = Gorals.fromJson(data);
      if (goral.data != null)
        return goral;
      else {
        print('error');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
