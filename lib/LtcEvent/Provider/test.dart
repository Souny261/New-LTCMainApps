import 'package:flutter/material.dart';
import 'package:ltcmainapp/LtcEvent/Provider/ProviderFunction.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Todo Application",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white70,
          ),
          onPressed: () {
            // resetID().then((value) {
            //   for (var i = 0; i < value.length; i++) {
            //     Provider.of<TodoModel>(context)
            //         .addTaskInList(value[i].id.toString(), value[i].title);
            //   }
            // });
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Text(
                "02 : 36 PM",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 45,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "current time",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ), //to show the clock

          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(60)),
                    color: Colors.white),
                child: Consumer<TodoModel1>(
                  builder: (context, todo, child) {
                    return ListView.builder(
                        itemCount: todo.taskList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: ListTile(
                              contentPadding: EdgeInsets.only(
                                  left: 32, right: 32, top: 8, bottom: 8),
                              title: Text(
                                todo.taskList[index].title,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                todo.taskList[index].detail,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(
                                Icons.check_circle,
                                color: Colors.greenAccent,
                              ),
                            ),
                            margin:
                                EdgeInsets.only(bottom: 8, left: 16, right: 16),
                          );
                        });
                  },
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<TodoModel1>(context, listen: false)
              .addTaskInList("value[i].id.toString()", "value[i].title");
        },
      ),
    );
  }
}

//   Future<List<Todos>> resetID() async {
//     try {
//       final response = await http.get(
//         'https://jsonplaceholder.typicode.com/todos',
//       );
//       if (response.statusCode == 200) {
//         var data = json.decode(response.body);
//         print(data);
//         return data.map<Todos>((json) => Todos.fromJson(json)).toList();
//       } else {}
//     } catch (e) {}
//   }
// }
