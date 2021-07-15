
import 'dart:convert';

import 'package:hive/hive.dart';
part 'detail_model.g.dart';    //! For hive Adapter 

DetailModel detailModelFromJson(String str) => DetailModel.fromJson(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
    DetailModel({
        required this.categories,
    });

    List<Category> categories;

    factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

@HiveType(typeId: 0)
class Category {
    Category({
       required this.id,
       required  this.name,
       required  this.timeStamp,
        required this.emailAddress,
        required this.phoneNumber,
        required this.requestContent,
    });
    @HiveField(0)
    int id;
    @HiveField(1)
    String name;
    @HiveField(2)
    DateTime timeStamp;
    @HiveField(3)
    String emailAddress;
    @HiveField(4)
    String phoneNumber;
    @HiveField(5)
    String requestContent;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        timeStamp: DateTime.parse(json["time_stamp"]),
        emailAddress: json["email_address"],
        phoneNumber: json["phone_number"],
        requestContent: json["request_content"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "time_stamp": timeStamp.toIso8601String(),
        "email_address": emailAddress,
        "phone_number": phoneNumber,
        "request_content": requestContent,
    };
}


