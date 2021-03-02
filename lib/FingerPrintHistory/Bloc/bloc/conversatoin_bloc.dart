import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/add_message.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/message_event.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/set_message.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/update_food.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class FingerBloc extends Bloc<FingerEvent, List<SumFingerModels>> {
  @override
  List<SumFingerModels> get initialState => List<SumFingerModels>();
  @override
  Stream<List<SumFingerModels>> mapEventToState(FingerEvent event) async* {
    if (event is SetFinger) {
      yield event.mesList;
    } else if (event is AddFinger) {
      List<SumFingerModels> newState = List.from(state);
      if (event.newMes != null) {
        newState.add(event.newMes);
      }
      yield newState;
    } else if (event is UpdateSum) {
      List<SumFingerModels> newState = List.from(state);
      newState[event.foodIndex] = event.newFood;
      yield newState;
    }
  }
}

class CounterBloc {
  int _counter;
  CounterBloc() {
    _counter = 1;
    _actionController.stream.listen(_increaseStream);
  }
  final _counterStream = BehaviorSubject<int>.seeded(1);
  Stream get pressedCount => _counterStream.stream;
  Sink get _addValue => _counterStream.sink;
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;
  void _increaseStream(data) {
    _counter = data;
    _addValue.add(_counter);
  }

  void dispose() {
    _counterStream.close();
    _actionController.close();
  }
}
