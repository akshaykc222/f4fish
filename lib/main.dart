import 'package:flutter/material.dart';
import 'package:grocery_app/injecter.dart';

import 'app.dart';

void main() async {
  await init();
  runApp(MyApp());
}
