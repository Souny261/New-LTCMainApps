import 'dart:async';
import 'package:rxdart/rxdart.dart';

class StartWorkBloc {
  String _time;
  StartWorkBloc() {
    _time = "00:00";
    _actionController.stream.listen(_increaseStream);
  }
  final _counterStream = BehaviorSubject<String>.seeded("00:00");
  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;
  void _increaseStream(data) {
    _time = data;
    _addValue.add(_time);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
  }
}

class OutWorkBloc {
  String _time;
  OutWorkBloc() {
    _time = "00:00";
    _actionController.stream.listen(_increaseStream);
  }
  final _counterStream = BehaviorSubject<String>.seeded("00:00");
  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;
  void _increaseStream(data) {
    _time = data;
    _addValue.add(_time);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
  }
}

class TotalWorkBloc {
  String _time;
  TotalWorkBloc() {
    _time = "00:00";
    _actionController.stream.listen(_increaseStream);
  }
  final _counterStream = BehaviorSubject<String>.seeded("00:00");
  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;
  void _increaseStream(data) {
    _time = data;
    _addValue.add(_time);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
  }
}


class ApiTekenBloc {
  String _time;
  ApiTekenBloc() {
    _time = "00:00";
    _actionController.stream.listen(_increaseStream);
  }
  final _counterStream = BehaviorSubject<String>.seeded("00:00");
  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;
  void _increaseStream(data) {
    _time = data;
    _addValue.add(_time);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
  }
}
