import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/model/todo/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() => [];

  final String _saveKey = "Todo";

  void save(Todo todo) async {
    final prefs = await SharedPreferences.getInstance();
    final targetList = [ ...state, todo ];
    final jsonList = targetList.map((todo) => json.encode(todo.toJson())).toList();
    prefs.setStringList(_saveKey, jsonList);
  }

  void loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_saveKey) ?? [];

    state = jsonList.map(
            (jsonStr) => Todo.fromJson(json.decode(jsonStr))
    ).toList();
  }

}
