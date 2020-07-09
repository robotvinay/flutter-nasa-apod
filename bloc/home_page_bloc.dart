import 'dart:async';

import 'package:flutter/material.dart';

class HomePageBloc {
  final StreamController _stream = StreamController();

  Sink get input => _stream.sink;
  Stream get ouput => _stream.stream;

  DateTime selectedDate = DateTime.now();

  Future<Null> buildDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1995, 6, 20),
        lastDate: selectedDate);

    if (picked != null && picked != selectedDate) {}
    // setState(() {
    //   selectedDate = picked;
    // });
  }

  closeStream() {
    _stream.close();
  }
}
