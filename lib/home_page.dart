import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _GameData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUIZ GAME'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _handleClickButton,
              child: const Text('LOAD GAME'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 1,
              itemBuilder: (context, index) => _buildListItem(context, index),
            ),
          ),
        ],
      ),
    );
  }

  _handleClickButton() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    var result = await http.get(url, headers: {'id': '07610645'});
    //print(result.body);

    var json = jsonDecode(result.body);
    String status = json['status'];
    String? message = json['message'];
    List<dynamic> data = json['data'];

    print('Status: $status, Message: $message, Number Game: ${data.length}');

    setState(() {
      for (var element in data) {
        _GameData.add(element);
      }
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    var foodItem = _GameData[1];
    String str = foodItem['choices'].join(" ");
    List<String> strarray = str.split(" ");

    // foodItem['choices'].forEach((item) {
    //   choice.add(item);
    // };

    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                foodItem['image_url'],
                width: 260.0,
                height: 260.0,
                fit: BoxFit.fill,
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              '${strarray[0]}',
                              style: GoogleFonts.prompt(fontSize: 20.0),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              '${strarray[1]}',
                              style: GoogleFonts.prompt(fontSize: 20.0),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              '${strarray[2]}',
                              style: GoogleFonts.prompt(fontSize: 20.0),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              '${strarray[3]}',
                              style: GoogleFonts.prompt(fontSize: 20.0),
                            ),

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
