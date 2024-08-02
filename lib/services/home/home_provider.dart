
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class HomeServices extends ChangeNotifier {
  List<Map<String, dynamic>> deylyGoals=[],monthlyGoals=[],weeklyGoals=[],yearlyGoals=[];
  Future<void> loadData(
      {required String datetime}) async {
    try {
      final date = datetime.split(" ");
      final thisweek = DateCalculater.instance.findLastDateOfTheWeek(DateTime.now()).toString().split(" ");
      final thismonth = DateCalculater.instance.findFirstDateOfTheMonth(DateTime.now()).toString().split(" ");
      final thisyear = DateCalculater.instance.findFirstDateOfTheYear(DateTime.now()).toString().split(" ");
      log(thisweek.toString());
    final data = await _firestore
        .collection("data/uid/data").where("type",isEqualTo: "Dey").where("create_at",isEqualTo: date.first)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    final week = await _firestore
        .collection("data/uid/data").where("type",isEqualTo: "Week").where("create_at",isEqualTo: thisweek.first)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
        log(week.toString());
    final month = await _firestore
        .collection("data/uid/data").where("type",isEqualTo: "Month").where("create_at",isEqualTo: thismonth.first)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
        log(week.toString());
    final year = await _firestore
        .collection("data/uid/data").where("type",isEqualTo: "Year").where("create_at",isEqualTo: thisyear.first)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
        log(week.toString());
        monthlyGoals=month;
        yearlyGoals=year;
        weeklyGoals=week;
        deylyGoals = data;
        notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> complete({required String type,required String datetime,required String id,required bool status,required Map<String,dynamic> map,required int index}) async {
    if(type=="Week")
    {
      weeklyGoals[index]["completed"] = status;
    }
    else if(type=="Month")
    {
      monthlyGoals[index]["completed"] = status;
    }
    else if(type=="Year")
    {
      yearlyGoals[index]["completed"] = status;
    }
    else{
      deylyGoals[index]["completed"] = status;
    }
    notifyListeners();
    await _firestore.collection("data/uid/data").doc(id).update({
      "uid": map["uid"],
      "id":id,
      "title": map["title"],
      "completed": status,
      "note": map["note"],
      "create_at": map["create_at"],
      "date": map["date"],
      "type":map["type"]
    });
        notifyListeners();
  }

  Future<void> updateData(
      {
      required String id,
      required String title,
      required Map<String,dynamic> map,
      required String? note,}) async {
    await _firestore.collection("data/uid/data").doc(id).update({
      "uid": map["uid"],
      "id":map["id"],
      "title": title,
      "completed": map["completed"],
      "note": note?? map["note"],
      "create_at": map["create_at"],
      "date": map["date"],
      "type":map["type"]
    });
        notifyListeners();
  }

  Future<void> deleteData(
      {required String type, required String datetime, required String id}) async {
    await _firestore.collection("data/uid/data").doc(id).delete();
        notifyListeners();
  }

  Future<void> addData(
      {required String type,
      required String datetime,
      required String title,
      required String note,
      required String id}) async {
    List<String> date; 
    if(type=="Week")
    {
      date =  DateCalculater.instance.findLastDateOfTheWeek(DateTime.now()).toString().split(" ");
    }
    else if(type=="Month")
    {
      date =  DateCalculater.instance.findFirstDateOfTheMonth(DateTime.now()).toString().split(" ");
    }
    else if(type=="year")
    {
      date =  DateCalculater.instance.findFirstDateOfTheYear(DateTime.now()).toString().split(" ");
    }
    else{
      date = datetime.split(" ");
    }
    await _firestore.collection("data/uid/data").doc(id).set({
      "uid": "uid",
      "id": id,
      "title": title,
      "completed": false,
      "note": note,
      "create_at": date.first,
      "type":type,
      "date": DateTime.now().microsecondsSinceEpoch
    });
    final data = await _firestore
        .collection("data/uid/data").where("type",isEqualTo: type).where("create_at",isEqualTo: date.first)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    deylyGoals = data;
    notifyListeners();
  }
}


class DateCalculater {
  DateCalculater._();
  static DateCalculater instance = DateCalculater._();

  DateTime findLastDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  DateTime findFirstDateOfTheMonth(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1);
  }

  DateTime findFirstDateOfTheYear(DateTime dateTime) {
    return DateTime(dateTime.year, 1, 1);
  }
}
