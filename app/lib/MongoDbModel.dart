// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.order_date,
    required this.school,
    required this.color,
    required this.length,
    required this.number,
    required this.order_status,
    required this.finish_date,
  });

  ObjectId id;
  String order_date;
  String school;
  String color;
  String length;
  String number;
  String order_status;
  String finish_date;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        order_date: json["order_date"],
        school: json["school"],
        color: json["color"],
        length: json["length"],
        number: json["number"],
        order_status: json["order_status"],
        finish_date: json["finish_date"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order_date": order_date,
        "school": school,
        "color": color,
        "length": length,
        "number": number,
        "order_status": order_status,
        "finish_date": finish_date,
      };
}
