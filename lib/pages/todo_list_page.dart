
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/todo/todo.dart';
import '../provider/todoList/todo_list_provider.dart';
import '../widgets/add_todo_dialog.dart';
import '../widgets/todo_card.dart';

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Todo> todoList = ref.watch(todoListProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(todoListProvider.notifier).loadAll();
      });
      return null;
    }, const []);

    final listWidget = (todoList.isEmpty)
        ? const EmptyTodoListWidget()
        : TodoListWidget(
      todoList: todoList,
      onItemDelete: (todo) async {
        await ref.read(todoListProvider.notifier).delete(todo);
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todoリスト'),
      ),
      body: Center(
        child: listWidget,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AddTodoDialog(
                    onAddClick: (title, description) async {
                      await ref.read(todoListProvider.notifier).save(title, description);
                      await ref.read(todoListProvider.notifier).loadAll();
                    }
                );
              }
          );
        },
        tooltip: 'Todoを追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({
    super.key,
    required this.todoList,
    required this.onItemDelete,
  });

  final List<Todo> todoList;
  final Function(Todo) onItemDelete;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return TodoCard(
                  todo: todoList[index],
                  onCardClick: (todo) {
                    //todo: クリック処理を入れる。
                  },
                  onCardDelete: (todo) {
                    onItemDelete(todo);
                  },
                  onDoneClick: (todo) {
                    //todo: 完了処理を入れる。
                  },
                );
              }
          ),
        )

      ],
    );
  }
}

class EmptyTodoListWidget extends ConsumerWidget {
  const EmptyTodoListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Todoリストが登録されていません。',
        )
      ],
    );
  }
}