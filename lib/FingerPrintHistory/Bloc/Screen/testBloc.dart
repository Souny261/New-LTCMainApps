import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/bloc/conversatoin_bloc.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/add_message.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/set_message.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/events/update_food.dart';
import 'package:ltcmainapp/FingerPrintHistory/Controller/fingerService.dart';
import 'package:ltcmainapp/FingerPrintHistory/DB/database_provider.dart';
import 'package:ltcmainapp/FingerPrintHistory/Models/fingerModels.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  FingerService service = new FingerService();
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getFingerBloc().then(
      (mesList) {
        BlocProvider.of<FingerBloc>(context).add(SetFinger(mesList));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire food list scaffold");
    return Scaffold(
      appBar: AppBar(
        title: Text("FoodList"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
              ),
              onPressed: () {
                DatabaseProvider.db.delete();
              }),
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                

                // DatabaseProvider.db.countMessage();
                // SumFingerModels models = SumFingerModels(
                //     dateTime: "2020-09-30",
                //     Finger: "1111",
                //     inTime: "2222",
                //     outTime: "33333",
                //     leaveCut: "4444",
                //     leaveNormal: "5555",
                //     leavePerson: "6666",
                //     OnDay: "77777โ");
                // // ConversationModel mes = ConversationModel(
                // //     refNo: 'refNo',
                // //     message: "Room1",
                // //     createDate: DateTime.now().toString(),
                // //     empID: 'empID',
                // //     refpk: 'refpk',
                // //     roomID: '2',
                // //     groupID: '1',
                // //     imageID: 'imageID',
                // //     status: 'status');
                // DatabaseProvider.db.insert(models).then(
                //       (storedFood) => BlocProvider.of<FingerBloc>(context).add(
                //         AddFinger(storedFood),
                //       ),
                //     );
              })
        ],
      ),
      body: Container(
        child: BlocConsumer<FingerBloc, List<SumFingerModels>>(
          builder: (context, foodList) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                SumFingerModels food1 = foodList[index];
                return ListTile(
                    onTap: () {
                      SumFingerModels food = SumFingerModels(
                          dateTime: food1.dateTime,
                          Finger: index.toString(),
                          inTime: "0",
                          outTime: "00",
                          leaveCut: "00",
                          leaveNormal: "0",
                          leavePerson: "0",
                          OnDay: "0000");
                      DatabaseProvider.db.update(food).then(
                            (storedFood) =>
                                BlocProvider.of<FingerBloc>(context).add(
                              UpdateSum(index, food),
                            ),
                          );
                    },
                    title: Text(food1.Finger, style: TextStyle(fontSize: 30)),
                    subtitle: Text(
                      "Calories: ${food1.dateTime}",
                      style: TextStyle(fontSize: 20),
                    ));
              },
              itemCount: foodList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: Colors.black),
            );
          },
          listener: (BuildContext context, foodList) {},
        ),
      ),
    );
  }
}
