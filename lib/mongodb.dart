import 'package:flutter/material.dart';

import 'package:mongo_dart/mongo_dart.dart';
import "constants.dart";

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
  }
}

searchInDb(String uid, String day) async {
  var db = await Db.create(MONGO_URL);

  await db.open();
  var collection = db.collection(COLLECTION_NAME);
  debugPrint("this uid $uid $COLLECTION_NAME");
  var res = await collection.findOne({"uid": uid});
  debugPrint("The complete: $res");
  if (res != null) {
    late bool attended;
    late String name;
    var attendVar = "attended1";
    var attendDate = "date_time_of_scan1";
    if ("day1" == day) {
      attendVar = "attended1";
      attendDate = "date_time_of_scan1";
    }
    if ("day2" == day) {
      attendVar = "attended2";
      attendDate = "date_time_of_scan2";
    }
    if ("day3" == day) {
      attendVar = "attended3";
      attendDate = "date_time_of_scan3";
    }
    if ("day4" == day) {
      attendVar = "attended4";
      attendDate = "date_time_of_scan4";
    }
    if ("day5" == day) {
      attendVar = "attended5";
      attendDate = "date_time_of_scan5";
    }
    if ("day6" == day) {
      attendVar = "attended6";
      attendDate = "date_time_of_scan6";
    }
    for (var entry in res.entries) {
      var attended;
      var req_key = entry.key;
      var req_val = entry.value;
      debugPrint("This is entry key: $req_key");
      debugPrint("This is entry value: $req_val");
      debugPrint("This is day: $day");
      debugPrint("The req values $attendVar $attendDate");

      if (entry.key == "name") {
        name = entry.value;
      }
      debugPrint("The truth: $req_key $day value $req_val");
      if (entry.key == attendVar) {
        attended = entry.value;
        debugPrint("Day value $attended");
      }
      if (attended == false) {
        debugPrint("Attend date $attendVar");
        await collection.update(
            where.eq("uid", uid), modify.set(attendVar, true));
        await collection.update(where.eq("uid", uid),
            modify.set(attendDate, DateTime.now().toString()));
        debugPrint("attended object: $attended");
        await db.close();
        return ["true", name];
      } else if (attended == true) {
        await db.close();
        return ["false", name];
      }
    }

    //   if (!attended) {
    //     await collection.update(
    //         where.eq("uid", uid), modify.set("attended", true));
    //     await collection.update(where.eq("uid", uid),
    //         modify.set("date_time_of_scan", DateTime.now().toString()));
    //     await db.close();
    //     return ["true", name];
    //   } else if (attended) {
    //     await db.close();
    //     return ["false", name];
    //   }
    // } else {
    //   await db.close();
    //   return ["Dosen't Exist", "none"]; // No record in db
    // }

    return ['a', 'b'];
  }
}
