import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_task/Homepage/Controller/homePageController.dart';
import 'package:pie_task/Model/detail_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ListDetailView extends StatelessWidget {
  final homeController = Get.find<HomePageController>();
  final DateTime dateTime;
  final int keyValue;

  ListDetailView(this.keyValue, this.dateTime);
  @override
  Widget build(BuildContext context) {
    //!
    final DateFormat formatter = DateFormat('h m a / dd-MM-yyyy ');
    final String formattedTime = formatter.format(dateTime);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(formattedTime, style: TextStyle(color: Colors.black)),
          ))
        ],
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.grey[300],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: ValueListenableBuilder(
        valueListenable: homeController.categoryBox.listenable(),
        builder: (context, Box<Category> todos, _) {
          final Category? categ = todos.get(keyValue);
          print('In');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.19,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          child: Text(
                            '${categ?.name[0].toUpperCase()}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          //! Title
                          child: Text(
                            categ!.name,
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! Email Button
                    deleteableItems(
                        elevatedbutton(categ.emailAddress, Icons.mail, () {
                          _launchURL(categ.emailAddress);
                        }), () {
                      homeController.categoryBox.putAt(
                          keyValue,
                          Category(
                              emailAddress: '',
                              id: categ.id,
                              name: categ.name,
                              phoneNumber: categ.phoneNumber,
                              requestContent: categ.requestContent,
                              timeStamp: categ.timeStamp));
                    }),

                    // //! Phone Button
                    deleteableItems(
                        elevatedbutton(categ.phoneNumber, Icons.phone,
                            () {
                          _makePhoneCall('tel:${categ.phoneNumber}');
                        }), () {
                      homeController.categoryBox.putAt(
                          keyValue,
                          Category(
                              emailAddress: categ.emailAddress,
                              id: categ.id,
                              name: categ.name,
                              phoneNumber: '',
                              requestContent: categ.requestContent,
                              timeStamp: categ.timeStamp));
                    }),

                    //! Message
                    deleteableItems(
                        Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              categ.requestContent,
                              style: TextStyle(fontSize: 15.4),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ), () {
                      homeController.categoryBox.putAt(
                          keyValue,
                          Category(
                              emailAddress: categ.emailAddress,
                              id: categ.id,
                              name: categ.name,
                              phoneNumber: categ.phoneNumber,
                              requestContent: '',
                              timeStamp: categ.timeStamp));
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ))),
    );
  }

//! Elevated Button
  Widget elevatedbutton(String txt, IconData iconData, ontap) {
    return ElevatedButton.icon(
      onPressed: ontap,
      icon: Icon(iconData),
      label: Text(txt),
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.black,
        primary: Colors.grey[300],
        textStyle: TextStyle(fontSize: 16),
      ),
    );
  }

  //!Phone
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //! Email
  void _launchURL(String emailId) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: emailId,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  Widget deleteableItems(
    Widget widget,
    var onPressFunction,
  ) {
    return FocusedMenuHolder(
        menuWidth: Get.width * 0.30,
        blurSize: 5.0,
        menuItemExtent: 45,
        menuBoxDecoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        duration: Duration(milliseconds: 100),
        animateMenuItems: true,
        blurBackgroundColor: Colors.black54,
        bottomOffsetHeight: 100,
        onPressed: () {},
        menuItems: <FocusedMenuItem>[
          FocusedMenuItem(
              title: Text(
                "Delete",
                style: TextStyle(color: Colors.redAccent),
              ),
              trailingIcon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: onPressFunction),
        ],
        child: widget);
  }
}
