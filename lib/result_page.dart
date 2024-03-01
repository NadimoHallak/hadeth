import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.wordSpoken, required this.data});

  final List<String> wordSpoken;
  final List<List<String>> data;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    super.initState();
    _comparison();
  }

  List<Text> textColor = [];
  _comparison() {
    if (widget.wordSpoken.length > widget.data[0].length) {
      for (var i = 0; i < widget.data[0].length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          textColor.add(Text(
            widget.wordSpoken[i],
            style: TextStyle(color: Colors.green),
          ));
        } else {
          textColor.add(Text(
            widget.wordSpoken[i],
            style: TextStyle(color: Colors.red),
          ));
        }
      }
    } else if (widget.wordSpoken.length < widget.data.length) {
      for (var i = 0; i < widget.wordSpoken.length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          textColor.add(Text(
            widget.wordSpoken[i],
            style: TextStyle(color: Colors.green),
          ));
        } else {
          textColor.add(Text(
            widget.wordSpoken[i],
            style: TextStyle(color: Colors.red),
          ));
        }
      }
    } else {
      for (var i = 0; i < widget.data[0].length; i++) {
        if (widget.wordSpoken[i] == widget.data[0][i]) {
          textColor.add(Text(
            widget.wordSpoken[i],
            style: TextStyle(color: Colors.green),
          ));
        } else {
          textColor.add(Text(
            widget.wordSpoken[i],
            style: TextStyle(color: Colors.red),
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: textColor,
      ),
    );
  }
}
