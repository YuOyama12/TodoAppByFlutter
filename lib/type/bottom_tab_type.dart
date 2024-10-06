import 'package:flutter/material.dart';

enum BottomTabType {
  todoList(
      path: "/",
      name: "todo_list",
      icon: Icons.home
  ),
  doneTodoList(
      path: "/done",
      name: "done_todo_list",
      icon: Icons.check
  )
  ;

  const BottomTabType({
    required this.path,
    required this.name,
    required this.icon
  });

  final String path;
  final String name;
  final IconData icon;
}