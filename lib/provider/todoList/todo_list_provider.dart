import 'dart:convert';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/model/todo/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() => [];

  final String _saveKey = "Todo";

  Future<void> save(String todoTitle, String todoDesc) async {
    final todo = Todo(
        id: await _getValidTodoId(),
        title: todoTitle,
        description: todoDesc,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()
    );

    final prefs = await SharedPreferences.getInstance();
    final targetList = [ ...state, todo ];
    final jsonList = targetList.map((todo) => json.encode(todo.toJson())).toList();
    prefs.setStringList(_saveKey, jsonList);
  }

  Future<void> loadAll() async {
    state = await _getTodoList();
  }

  Future<List<Todo>> _getTodoList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_saveKey) ?? [];

    return jsonList.map(
            (jsonStr) => Todo.fromJson(json.decode(jsonStr))
    ).toList();
  }

  Future<int> _getValidTodoId() async {
    final todoList = await _getTodoList();
    if(todoList.isEmpty) {
      return 1;
    } else {
      final currentIds = todoList.map((todo) => todo.id).toList();
      final currentMaxId = currentIds.reduce(max);
      return currentMaxId + 1;
    }
  }

}
