import 'dart:developer';
import 'package:app/MongoDbModel.dart';
import 'package:app/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getQueryData(
      String schoolName,
      String orderStatus,
      String orderStart,
      String orderEnd,
      String finishStart,
      String finishEnd) async {
    SelectorBuilder queryBuilder = where;

    //queryBuilder = queryBuilder.eq("school", "SMK Hutan Melintang");

    if (schoolName != '未选择') {
      queryBuilder = queryBuilder.eq("school", schoolName);
    }
    if (orderStatus != '未选择') {
      queryBuilder = queryBuilder.eq("order_status", orderStatus);
    }
    if (orderStart != '未选择') {
      queryBuilder = queryBuilder.gt("order_date", orderStart);
    }
    if (orderEnd != '未选择') {
      queryBuilder = queryBuilder.lt("order_date", orderEnd);
    }
    if (finishStart != '未选择') {
      queryBuilder = queryBuilder.gt("finish_date", finishStart);
    }
    if (finishEnd != '未选择') {
      queryBuilder = queryBuilder.lt("finish_date", finishEnd);
    }

    final data = await userCollection
        .find(queryBuilder.sortBy("order_date", descending: false))
        .toList();
    return data;
  }

  static Future<List<String>> getSchool() async {
    final arrSchoolData = await userCollection.distinct("school");
    //return arrSchoolData;

    Map<String, dynamic> thisisschool =
        Map<String, dynamic>.from(arrSchoolData);

    List<String> allSchool = ['未选择'];

    String data1;

    var response = await thisisschool.values.toList();

    for (String i in response[0]) {
      //for (int j = 0; j < i.length; j++) {
      data1 = i;
      allSchool.add(data1);
      //}
    }
    //print(allSchool);
    return allSchool;
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted.";
      } else {
        return "Something went wrong during the insert operation.";
      }
    } catch (e) {
      //print(e.toString());
      return e.toString();
    }
  }

  static Future<void> update(MongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['order_date'] = data.order_date;
    result['school'] = data.school;
    result['color'] = data.color;
    result['length'] = data.length;
    result['number'] = data.number;
    result['order_status'] = data.order_status;
    result['finish_date'] = data.finish_date;
    var response = await userCollection.save(result);
    inspect(response);
  }

  static delete(MongoDbModel data) async {
    await userCollection.remove(where.id(data.id));
  }
}
