import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pie_task/Homepage/homepage.dart';
import 'package:pie_task/Model/detail_model.dart';

import 'Constants/constants.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final documnet = await getApplicationDocumentsDirectory();
  Hive.init(documnet.path);
  Hive.registerAdapter(CategoryAdapter());
  await Hive.openBox<Category>(hiveBoxName);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.grey[300],
  statusBarBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

