import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapps/models/http_provider.dart';

class ListTileCustom extends StatefulWidget {
  final int indexVal;

  ListTileCustom({
    super.key,
    required this.indexVal,
  });

  @override
  State<ListTileCustom> createState() => _ListTileCustomState();
}

class _ListTileCustomState extends State<ListTileCustom> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<HttpUser>(context, listen: true);

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
                          value.todo[widget.indexVal].title!.toString(),
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
                          value.todo[widget.indexVal].subTitle!,
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
                prov.deleteUser(prov.todo[0].id!).then((value) {
                  setState(() {
                    print('object');
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
