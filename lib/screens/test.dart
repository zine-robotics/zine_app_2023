import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late List items;

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/screenData.json');
    final data = await json.decode(response);
    setState(() {
      items = data["achivement"]["tiles"];
    });
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemBuilder: ((context, index) {
            return Card(
              child: ListTile(
                title: Text(items[index]["title"]),
              ),
            );
          }),
        ),
      ),
    );
  }
}
