import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapps/models/http_provider.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});
  static const routeName = '/addtodo';

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _title = TextEditingController();
  final _subTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<HttpUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ADD TODO',
          style: TextStyle(fontFamily: 'Lato'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _subTitle,
              decoration: InputDecoration(
                labelText: "Sub Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                prov.addToto(_title.text, _subTitle.text).then((value) {
                  Navigator.of(context).pop();
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade800,
                ),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
