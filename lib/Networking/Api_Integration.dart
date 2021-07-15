import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pie_task/Constants/constants.dart';
import 'package:pie_task/Model/detail_model.dart';

class FetchingApi {
  List<Category> category = [];
  
  Future<void> getData() async {
    var url = Uri.parse(apiUrl);
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    try {
      var detailModel = DetailModel.fromJson(jsonData);
      var detailModelCategory = detailModel.categories;
      detailModelCategory.forEach((element) {
        category.add(element);
      });
      print(category[0].name);

    } catch (e) {
      print(e);
    }
  }
}
