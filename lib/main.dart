import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltcmainapp/Controller/provider.dart';
import 'package:ltcmainapp/FingerPrintHistory/Bloc/bloc/conversatoin_bloc.dart';
import 'package:ltcmainapp/LtcEvent/Provider/ProviderFunction.dart';
import 'package:ltcmainapp/checkPage.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => WorkingTimeStart()),
        ChangeNotifierProvider(create: (_) => WorkingTimeEnd()),
        ChangeNotifierProvider(create: (_) => TodoModel1()),
        ChangeNotifierProvider(create: (_) => WorkProcessProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FingerBloc>(
      create: (context) => FingerBloc(),
      child: MaterialApp(
        home: checkPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
