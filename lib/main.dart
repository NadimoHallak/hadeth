import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:testttttttttttt/result_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
      home: const MyHomePage(
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

  String speeshResult = "";
  List<List<String>> data = [];

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
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      speeshResult = result.recognizedWords;
    });
  }

  void _onSpeechStop() async {
    await speechToText.stop();
  }

  void getDataFromExcel() async {
    var filePath = 'assets/files/name.xlsx';
    final bytesData = await rootBundle.load(filePath);
    final bytes = bytesData.buffer.asUint8List(
      bytesData.offsetInBytes,
      bytesData.lengthInBytes,
    );
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        for (var cell in row) {
          if (cell!.value is TextCellValue) {
            String temp = cell.value.toString();
            data.add(temp.split(" "));
          }
        }
      }
    }
    print(data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () async {
            if (speechToText.isListening) {
              _onSpeechStop();
            } else {
              _startListening();
            }
          },
          child: Icon(
            speechToText.isNotListening ? Icons.mic_off : Icons.mic,
            color: Colors.white,
          )),
      appBar: AppBar(
        title: const Text(
          "سمع الحديث الشريف",
          style:
              TextStyle(color: Color.fromARGB(255, 5, 96, 216), fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                speeshResult.toString(),
                style: const TextStyle(fontSize: 17),
                textDirection: TextDirection.rtl,
              ),
            ),
            if (speeshResult.trim().isNotEmpty)
              MaterialButton(
                onPressed: () {
                  setState(() {
                    wordSpoken = speeshResult.split(" ");
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResultPage(wordSpoken: wordSpoken, data: data),
                    ),
                  );
                },
                child: const Text(
                  "إذهب إلى صفحة النتائج",
                  style: TextStyle(
                    color: Color.fromARGB(255, 184, 5, 5),
                    fontSize: 15,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
