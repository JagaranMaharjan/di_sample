import 'dart:ffi';

import 'package:di_sample/core/service/shared_prefs_service.dart';
import 'package:di_sample/features/product/presentation/screens/faq_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/injectable.dart';
import 'features/product/presentation/bloc/faq_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FaqBloc>.value(
      value: getIt<FaqBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              'DI Demo',
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Shared Prefs Data:\n ${getIt<SharedPrefsService>().readKey(key: 'test')}',
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              getIt<SharedPrefsService>()
                  .storeValue(key: "test", value: "Hi, hello");
            },
            child: const Text("Store Key"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return const FAQScreen();
              },
            ),
          );
        },
        tooltip: 'FAQ',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
