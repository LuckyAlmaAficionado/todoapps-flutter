import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapps/models/http_provider.dart';
import 'package:todoapps/pages/add_todo.dart';
import 'package:todoapps/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HttpUser(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          AddTodo.routeName: (context) => AddTodo(),
        },
      ),
    );
  }
}
