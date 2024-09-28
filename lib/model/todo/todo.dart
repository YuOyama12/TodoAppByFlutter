import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class Todo with _$Todo {

  const factory Todo({
    required int id,
    required String title,
    required String description,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isDeleted
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  static final mockTodoList = List.generate(30, (i)=> mockTodo(i));
  static final List<Todo> mockEmptyTodoList = [];
}

Todo mockTodo(int id) {
  return Todo(
      id: id,
      title: "テストタイトル",
      description: "description",
      createdAt: DateTime(2024, 10, 1),
      updatedAt: DateTime(2024, 10, 1)
  );
}
