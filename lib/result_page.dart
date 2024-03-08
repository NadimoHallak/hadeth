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
  Color correctColor = const Color.fromARGB(255, 5, 216, 93);

  int errorCount = 0;
  int trueCount = 0;
  List<Text> correctErrorText = [];
  List<Text> correctText = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "حديث النيات",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
              Text(
                errorCount > 0 ? "{مكان تواجد الأخطاء}" : "{لا يوجد أخطاء}",
                style: const TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  textDirection: TextDirection.rtl,
                  children: correctErrorText,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              if (errorCount > 0)
                const Text(
                  "{تصحيح الأخطاء}",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 20,
                  ),
                ),
              if (errorCount > 0)
                const SizedBox(
                  height: 15,
                ),
              if (errorCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    textDirection: TextDirection.rtl,
                    children: correctText,
                  ),
                ),
              if (errorCount > 0)
                const SizedBox(
                  height: 30,
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _comparison();
  }

  _comparison() {
    if (widget.wordSpoken.length > widget.data[0].length) {
      //! first For -----------------------------------------
      for (var i = 0; i < widget.data[0].length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          trueCount++;
          correctErrorText.add(
            Text(
              "${widget.wordSpoken[i]} ",
              style: TextStyle(
                color: trueColor,
                fontSize: 18,
              ),
            ),
          );
          correctText.add(
            Text(
              "${widget.wordSpoken[i]} ",
              style: TextStyle(
                color: trueColor,
                fontSize: 18,
              ),
            ),
          );
        } else {
          if (i + 1 < widget.data[0].length &&
              widget.wordSpoken[i] == widget.data[0][i + 1]) {
            errorCount += 2;
            correctErrorText.add(
              Text(
                ".....",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (i + 2 < widget.data[0].length &&
              widget.wordSpoken[i] == widget.data[0][i + 2]) {
            errorCount += 3;
            correctErrorText.add(
              Text(
                "..........",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (widget.wordSpoken[i] == widget.data[0][i - 1] && i > 0) {
            errorCount += 2;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                ".....",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (widget.wordSpoken[i] == widget.data[0][i - 2] && i > 1) {
            errorCount += 3;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "..........",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            errorCount++;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          }
        }
      } //! first For -----------------------------------------
      for (var i = correctText.length; i < widget.data[0].length; i++) {
        errorCount++;
        correctErrorText.add(
          Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        );
        correctText.add(
          Text(
            "${widget.wordSpoken[i]} ",
            style: TextStyle(
              color: correctColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        );
      }
    } else if (widget.wordSpoken.length < widget.data[0].length) {
      for (var i = 0; i < widget.wordSpoken.length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          trueCount++;

          correctErrorText.add(
            Text(
              "${widget.wordSpoken[i]} ",
              style: TextStyle(
                color: trueColor,
                fontSize: 18,
              ),
            ),
          );
          correctText.add(
            Text(
              "${widget.wordSpoken[i]} ",
              style: TextStyle(
                color: trueColor,
                fontSize: 18,
              ),
            ),
          );
        } else {
          if (widget.wordSpoken[i] == widget.data[0][i + 1] &&
              i + 1 < widget.wordSpoken.length) {
            errorCount += 2;
            correctErrorText.add(
              Text(
                ".....",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (i + 2 < widget.wordSpoken.length &&
              widget.wordSpoken[i] == widget.data[0][i + 2]) {
            errorCount += 3;
            correctErrorText.add(
              Text(
                "..........",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (widget.wordSpoken[i] == widget.data[0][i - 1] && i > 0) {
            errorCount += 2;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                ".....",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (i > 1 && widget.wordSpoken[i] == widget.data[0][i - 2]) {
            errorCount += 3;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "..........",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            errorCount++;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          }
        }
      }
      for (var i = widget.wordSpoken.length; i < widget.data[0].length; i++) {
        correctErrorText.add(
          Text(
            "${widget.data[0][i]} ",
            style: TextStyle(
              color: errorColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        );
      }
    } else {
      for (var i = 0; i < widget.data[0].length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          trueCount++;

          correctErrorText.add(
            Text(
              "${widget.wordSpoken[i]} ",
              style: TextStyle(
                color: trueColor,
                fontSize: 18,
              ),
            ),
          );
          correctText.add(
            Text(
              "${widget.wordSpoken[i]} ",
              style: TextStyle(
                color: trueColor,
                fontSize: 18,
              ),
            ),
          );
        } else {
          if (widget.wordSpoken[i] == widget.data[0][i + 1] &&
              i + 1 < widget.wordSpoken.length) {
            errorCount += 2;
            correctErrorText.add(
              Text(
                ".....",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (widget.wordSpoken[i] == widget.data[0][i + 2] &&
              i + 2 < widget.wordSpoken.length) {
            errorCount += 3;
            correctErrorText.add(
              Text(
                "..........",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (widget.wordSpoken[i] == widget.data[0][i - 1] && i > 0) {
            errorCount += 2;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                ".....",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          } else if (i > 1 && widget.wordSpoken[i] == widget.data[0][i - 2]) {
            errorCount += 3;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: trueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctErrorText.add(
              Text(
                "..........",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          } else {
            errorCount++;
            correctErrorText.add(
              Text(
                "${widget.wordSpoken[i]} ",
                style: TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
            correctText.add(
              Text(
                "${widget.data[0][i]} ",
                style: TextStyle(
                  color: correctColor,
                  fontSize: 18,
                ),
              ),
            );
          }
        }
      }
    }
  }
}
