import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  List<dynamic> users = [];

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data From API")),
      body: ListView.builder(
          itemCount: widget.users.length,
          itemBuilder: (contex, index) {
            final user = widget.users[index];
            final name = user["name"];
            return ListTile(
              leading: CircleAvatar(child: Text("${index + 1}")),
              title: Text(name),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: getData,
        child: const Center(
          child: Text(
            "Get Data",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  getData() async {
    try {
      const url =
          "https://63a5bb3df8f3f6d4abfe41ac.mockapi.io/test1/flutter-practice";

      final uri = Uri.parse(url);

      var response = await http.get(uri);
      var body = response.body;
      var json = jsonDecode(body);
      setState(() {
        widget.users = json;
      });

      print("status code ${response.statusCode}");
    } on SocketException {
      print("No internet");
    } catch (e) {
      print(e);
    }
  }
}
