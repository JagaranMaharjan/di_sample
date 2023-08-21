import 'dart:async';

import 'package:flutter/material.dart';

import 'core/config/injectable.dart';
import 'main.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
  /// FUNC [runZonedGuarded] : Use it if you have dependency that needs to be awaited like shared prefs
  /// Pass ensureInitialized to tell flutter to wait until every this is ok
  // return runZonedGuarded(() => runApp(const MyApp()), (error, stack) {
  //   print(error);
  //   print(stack);
  // });
}
