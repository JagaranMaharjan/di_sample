import 'dart:async';

import 'package:flutter/material.dart';

import 'core/di/injectable.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}
