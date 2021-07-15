import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pie_task/Constants/constants.dart';
import 'package:pie_task/Model/detail_model.dart';
import 'package:pie_task/Networking/Api_Integration.dart';

class HomePageController extends GetxController with WidgetsBindingObserver {
  RxList<Category> categoryList = <Category>[].obs;
  RxBool isLoading = true.obs;
  late Box<Category> categoryBox;

  @override
  void onInit() {
    getDataFromApi();

    WidgetsBinding.instance!.addObserver(this);
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        print('App is Paused');
        break;
      case AppLifecycleState.detached:
        print('App is detached');
        break;
      case AppLifecycleState.inactive:
        categoryBox.clear();
        print('App is inactive');
        break;
      case AppLifecycleState.resumed:
        getDataFromApi();
        print('App is resumed');
        break;
    }
  }

  getDataFromApi() async {
    categoryBox = Hive.box<Category>(hiveBoxName);
    if (categoryBox.isEmpty) {
      FetchingApi fetchCategory = FetchingApi();
      await fetchCategory.getData();
      var fetch = fetchCategory.category;
      fetch.forEach((element) {
        categoryBox.add(element);
      });
      categoryList.value = fetch;
      isLoading.value = false;
      update();
    } else {
      print('Already Have Data On local Storage');
    }
  }
}
