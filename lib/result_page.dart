import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.wordSpoken, required this.data});

  final List<String> wordSpoken;
  final List<List<String>> data;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  // List<Text> correctedText = [];

  Color errorColor = const Color.fromARGB(255, 184, 5, 5);
  Color trueColor = const Color.fromARGB(255, 5, 96, 216);
  double errorCount = 0;
  double trueCount = 0;
  List<Text> textColor = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "حديث النيات",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              const Color.fromARGB(255, 253, 82, 82),
                          child: Text(
                            trueCount == 0
                                ? widget.data[0].length.toString()
                                : trueCount != widget.data[0].length
                                    ? (widget.data[0].length - trueCount)
                                        .toString()
                                    : errorCount.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 25),
                          ),
                        ),
                        const Text(
                          "عدد الأخطاء",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  // textBaseline: ,
                  textDirection: TextDirection.rtl,
                  children: textColor,
                  // mainAxisAlignment: MainAxisAlignment.end,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    _comparison();
  }

  _comparison() {
    if (widget.wordSpoken.length > widget.data[0].length) {
      for (var i = 0; i < widget.data[0].length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          trueCount++;
          textColor.add(Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: trueColor,
              fontSize: 18,
            ),
          ));
        } else {
          errorCount++;
          textColor.add(Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ));
        }
      }
      for (var i = widget.data[0].length; i < widget.wordSpoken.length; i++) {
        errorCount++;
        textColor.add(Text(
          "${widget.wordSpoken[i]} ",
          style: TextStyle(
            color: errorColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ));
      }
    } else if (widget.wordSpoken.length < widget.data[0].length) {
      for (var i = 0; i < widget.wordSpoken.length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          trueCount++;

          textColor.add(Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: trueColor,
              fontSize: 18,
            ),
          ));
        } else {
          errorCount++;
          textColor.add(Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ));
        }
      }
    } else {
      for (var i = 0; i < widget.data[0].length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          trueCount++;

          textColor.add(Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: trueColor,
              fontSize: 18,
            ),
          ));
        } else {
          errorCount++;
          textColor.add(Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ));
        }
      }
    }
  }
}
