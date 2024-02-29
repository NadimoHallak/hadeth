import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:testttttttttttt/test_excel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Excel Demo',
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
  final SpeechToText speechToText = SpeechToText();

  String str = "";
  List<List<dynamic>> data = [];

  List<List<String>> text = [];

  List<String> wordSpoken = [];

  @override
  void initState() {
    super.initState();
    getDataFromExcel();
    _initSpeech();
  }

  void _initSpeech() async {
    await speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await speechToText.listen(
      onResult: _onSpeechResult,
    );

    setState(() {
      print("start..");
      // _confidenceLevel = 0;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print("Result");
    setState(() {
      wordSpoken = result.recognizedWords.split(" ");
      // _confidenceLevel = result.confidence;
    });
  }

  void _onSpeechStop() async {
    await speechToText.stop();
    setState(() {});
  }

  getDocsDir() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    print(path);
  }

  void getDataFromExcel() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    var filePath = '$path/assets/files/name.xlsx';
    File file = await File(filePath).create(recursive: true);
var type = file.
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      print(excel.tables[table]!.maxColumns);
      print(excel.tables[table]!.maxRows);

      for (var row in excel.tables[table]!.rows) {
        for (var i = 0; i < row.length; i++) {
          data[i] = row;
        }
      }
    }
    setState(() {});
  }

  void getDataDetails() {
    for (var i = 0; i < data.length; i++) {
      String temp = data[i][1].toString();
      text[i] = temp.split(" ");
    }
    print(text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          // onPressed: () {
          //   print(_textFromFile);
          // },
          onPressed: () async {
            await getDocsDir();
            // getDataDetails();

            // await _getData();
            // if (speechToText.isListening) {
            // _onSpeechStop();
            // } else {
            // _startListening();
            // }
          },
          child: Icon(speechToText.isListening ? Icons.mic_off : Icons.mic)),
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Text("from file : ${str}"),
            Text(wordSpoken.toString()),
            // SizedBox(
            //   width: 200,
            //   height: 100,
            //   child: ListView.builder(
            //     // scrollDirection: Axis.horizontal,
            //     itemCount: _text.length,
            //     itemBuilder: (context, index) {
            //       if (wordSpoken.isNotEmpty &&
            //           _text.isNotEmpty &&
            //           wordSpoken[index] == _text[index]) {
            //         return Text(
            //           _text[index],
            //           style: const TextStyle(color: Colors.green),
            //         );
            //       } else {
            //         return const Text(
            //           "Empty _wordSpoken",
            //           style: TextStyle(color: Colors.red),
            //         );
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
