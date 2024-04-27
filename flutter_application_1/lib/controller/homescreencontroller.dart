import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/api_model.dart';
import 'package:http/http.dart ' as http;

class homescreencontroller with ChangeNotifier {
  List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];
  NewApiModel? resBycategory;
  int selectedCategoryIndex = 0;
  bool isLoading = false;
  Future getDataByCategory() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=${categories[selectedCategoryIndex]}&apiKey=4ef7078908b548e283f2c1344627d0eb");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodeData = jsonDecode(response.body);
      resBycategory = NewApiModel.fromJson(decodeData);
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }
  // on category selection

  onCategorySelection(int value) {
    selectedCategoryIndex = value;
    notifyListeners();
    getDataByCategory();
  }

  // recivedData() async {
  //   isLoading = true;
  //   notifyListeners();
  //   Uri url = Uri.parse(
  //       "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ef7078908b548e283f2c1344627d0eb");
  //   var response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     var decodeData = jsonDecode(response.body);
  //   } else {
  //     print("failed");
  //   }
  //   isLoading = false;
  //   notifyListeners();
  // }
}
