import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_task/Model/detail_model.dart';
import 'package:pie_task/Widgets/ListView.Widget.dart';
import 'Controller/homePageController.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pie_task/Widgets/ListDetailView.dart';

class HomePage extends StatelessWidget {
  final homepageController = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text('Messages',style: TextStyle(color: Colors.black),),
       brightness: Brightness.light
      ),
      body: SafeArea(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: homepageController.categoryBox.listenable(),
              builder: (context, Box<Category> boxcateg, _) {
                List<int> keys = boxcateg.keys.cast<int>().toList();
                print('In');
                print(keys.length);
                return Container(
                  height: Get.height * 0.83,
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      final int key = keys[index];
                      final Category? categ = boxcateg.get(key);
                      final DateFormat formatter = DateFormat('h m a');
                      final String formattedTime =
                          formatter.format(categ!.timeStamp);

                      return ListViewWidget(
                          categ.name, categ.requestContent, formattedTime, () {
                        Get.to(ListDetailView(key,categ.timeStamp));
                      });
                    },
                   
                    itemCount: keys.length,
                    shrinkWrap: true,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
