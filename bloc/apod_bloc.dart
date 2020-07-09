import 'dart:async';
import 'dart:convert';

import 'package:apod_nasa/connection/connection.dart';
import 'package:apod_nasa/model/apod.dart';

class APODBloc {
  final StreamController _streamController = StreamController();
  // Sink: entrada; Stream: saída.
  Sink get input => _streamController.sink;
  Stream get ouput => _streamController.stream;

  var users = new List<APOD>();

  _getAPODs() {
    API.getAPOD().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        users = lista.map((model) => APOD.fromJson(model)).toList();
      });
    });
  }
}
