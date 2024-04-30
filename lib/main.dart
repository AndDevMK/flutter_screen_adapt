import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_adapt/second/screen_adapt_binding.dart';

void main() {
  _runApp(const MyApp());
}

void _runApp(Widget app) {
  final WidgetsBinding binding = ScreenAdaptBinding.ensureInitialized();
  assert(binding.debugCheckZone('_runApp'));
  Timer.run(() {
    binding.attachRootWidget(binding.wrapWithDefaultView(app));
  });
  binding.scheduleWarmUpFrame();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: (BuildContext context, Widget? child) {
        /// fixme：修正MediaQuery尺寸等参数，注意不能在修正之前使用MediaQuery
        final screenAdaptBinding = WidgetsBinding.instance as ScreenAdaptBinding;
        final viewConfiguration = screenAdaptBinding.viewConfiguration;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: viewConfiguration.size,
            devicePixelRatio: viewConfiguration.devicePixelRatio,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const MyHomePage(title: 'Flutter Screen Adapt'),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
        child: Container(
          /// 375/2
          width: 187.5,

          height: 375,
          color: Colors.blueAccent,
          child: const Text(
            '14字号大小',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
