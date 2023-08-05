import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapps/models/todo.dart';

class HttpUser with ChangeNotifier {
  List<Todo> _todo = [];

  List<Todo> get todo => _todo;

  int get userLenght => _todo.length;

  Future<void> deleteUser(int id) {
    Uri url = Uri.parse(
        "https://backend-todo-production-a36d.up.railway.app/todo/delete-todo/" +
            id.toString());

    return http.delete(url).then((value) {
      _todo.removeWhere((element) => element.id == id);

      notifyListeners();
    });
  }

  Future<void> addToto(String title, String subTitle) async {
    Uri url = Uri.parse(
        "https://backend-todo-production-a36d.up.railway.app/todo/post-todo");

    await http
        .post(
      url,
      headers: {
        'Content-Type':
            'application/json', // Atur header Content-Type sebagai JSON
      },
      body: json.encode({
        "title": title, // Gunakan nilai dari parameter
        "subTitle": subTitle, // Gunakan nilai dari parameter
      }),
    )
        .then((value) {
      var response = (jsonDecode(value.body))['data'];
      _todo.add(Todo(
          id: response['id'],
          todoUUID: response['todoUUID'],
          title: response['title'],
          subTitle: response['subTitle'],
          createdAt: response['createdAt']));
    });

    notifyListeners();
  }

  Future<void> initTodo() async {
    _todo.clear();

    Uri url = Uri.parse(
        "https://backend-todo-production-a36d.up.railway.app/todo/get-todo");

    var response = await http.get(url);

    ((json.decode(response.body))['data'] as List<dynamic>).forEach((element) {
      _todo.add(Todo(
          id: element['id'],
          todoUUID: element['todoUUID'],
          title: element['title'],
          subTitle: element['subTitle'],
          createdAt: element['createdAt']));
    });

    notifyListeners();
  }
}
