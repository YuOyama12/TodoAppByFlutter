import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app_flutter/model/todo/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() => [];
}
