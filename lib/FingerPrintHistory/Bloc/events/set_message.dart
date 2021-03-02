import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/message_event.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';

class SetFinger extends FingerEvent {
  List<SumFingerModels> mesList;
  SetFinger(List<SumFingerModels> mes) {
    mesList = mes;
  }
}
