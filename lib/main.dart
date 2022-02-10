import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:theme_helper/providers/layout_provider.dart';

import 'widgets/edge_resizeable_container.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final appLayout = watch(layoutProvider);
      double screenWidth = MediaQuery.of(context).size.width;
      Future.delayed(const Duration(milliseconds: 0), () {
        appLayout.appWidth = screenWidth;
      });
      return Scaffold(
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              EdgeResizeableContainer(
                child: Container(
                  height: double.infinity,
                  color: Colors.transparent,
                ),
                onRightResize: (double newWidth) {
                  appLayout.leftDivider = newWidth;
                },
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: (Theme.of(context).brightness == Brightness.light)
                          ? Colors.black
                          : Colors.white,
                      width: 1,
                    ),
                  ),
                ),
                initialWidth: appLayout.leftDivider,
              ),
              Flexible(
                child: Container(
                  height: double.infinity,
                  width: screenWidth,
                ),
              ),
              EdgeResizeableContainer(
                child: Container(
                  height: double.infinity,
                  // width: appLayout.rightDivider,
                  color: Colors.transparent,
                ),
                onLeftResize: (double newWidth) {
                  appLayout.rightDivider = newWidth;
                },
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: (Theme.of(context).brightness == Brightness.light)
                          ? Colors.black
                          : Colors.white,
                      width: 1,
                    ),
                  ),
                ),
                initialWidth: appLayout.rightDivider,
              ),
            ],
          ),
        ),
      );
    });
  }
}
