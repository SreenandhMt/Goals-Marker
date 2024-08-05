import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goal_marker/firebase_options.dart';
import 'package:goal_marker/services/home/home_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //  await HomeServices().addData(type: "dey", datetime: DateTime.now().toString(),id: DateTime.now().microsecondsSinceEpoch.toString());
  //  print(data.toString());
}
