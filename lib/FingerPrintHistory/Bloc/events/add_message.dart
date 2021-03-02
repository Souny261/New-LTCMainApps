import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';
import 'message_event.dart';
class AddFinger extends FingerEvent {
  SumFingerModels newMes;
  AddFinger(SumFingerModels mes) {
    newMes = mes;
  }
}
