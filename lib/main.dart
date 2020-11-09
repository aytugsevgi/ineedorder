import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ineedorder/view/home_view.dart';
import 'package:path_provider/path_provider.dart';

import 'model/plan.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(PlanAdapter());

  await Hive.openBox<Plan>("0");
  await Hive.openBox<Plan>("1");
  await Hive.openBox<Plan>("2");
  await Hive.openBox<Plan>("3");
  await Hive.openBox<Plan>("4");
  await Hive.openBox<Plan>("5");
  await Hive.openBox<Plan>("6");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
    );
  }
}
