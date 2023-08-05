import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapps/models/http_provider.dart';
import 'package:todoapps/pages/add_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const routeName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<HttpUser>(context).initTodo();
      print('keluar');
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isInit = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<HttpUser>(context);

    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddTodo.routeName);
              },
              icon: Icon(Icons.add))
        ],
        title: Text(
          'TO-DO',
          style: TextStyle(
            fontFamily: 'Lato',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: prov.userLenght,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // icons
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(
                            255,
                            Random().nextInt(255),
                            Random().nextInt(255),
                            Random().nextInt(255),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        height: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.bed_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 230,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<HttpUser>(
                              builder: (context, value, child) => Text(
                                value.todo[index].title!.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Valera',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Consumer<HttpUser>(
                              builder: (context, value, child) => Text(
                                value.todo[index].subTitle!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  //
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      prov.deleteUser(prov.todo[index].id!).then((value) {
                        print('object');
                      });
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
