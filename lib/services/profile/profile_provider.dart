import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ProfileServcies extends ChangeNotifier {
  Map<DateTime, int>? progress = {};
  Future<void> loadUserProgress() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final progressData = await _firestore
        .collection("progress")
        .doc(uid)
        .get()
        .then((value) => value.data());
    final date = await _firestore
        .collection("progressDate")
        .doc(uid)
        .get()
        .then((value) => value.data());
    if (progressData != null && date != null) {
      for (var e in date["progressDate"]) {
        Map<DateTime, int> temp = {
          DateTime.parse(e): (10 * progressData["progress$e"]).toInt()
        };
        progress!.addEntries(temp.entries);
      }
    }
    notifyListeners();
  }
}
