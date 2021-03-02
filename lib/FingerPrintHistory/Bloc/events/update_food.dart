
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/message_event.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';

class UpdateSum extends FingerEvent {
  SumFingerModels newFood;
  int foodIndex;

  UpdateSum(int index, SumFingerModels food) {
    newFood = food;
    foodIndex = index;
  }
}
