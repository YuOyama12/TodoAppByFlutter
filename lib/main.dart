import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_flutter/model/todo/todo.dart';
import 'package:todo_app_flutter/widgets/add_todo_dialog.dart';
import 'package:todo_app_flutter/widgets/todo_card.dart';

void main() {
  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TodoListPage(
        title: 'Todoリスト',
        todoList: Todo.mockTodoList,
      ),
    );
  }
}

class TodoListPage extends HookConsumerWidget {
  const TodoListPage({
    super.key,
    required this.title,
    required this.todoList,
  });

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  final List<Todo> todoList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listWidget = (todoList.isEmpty)
        ? const EmptyTodoListWidget()
      : TodoListWidget(
            todoList: todoList
        );

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout listWidget. It takes a single child and positions it
        // in the middle of the parent.
        child: listWidget,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (_) {
                return AddTodoDialog(
                    onAddClick: (todoText) => {
                      //todo: 追加処理を入れる。
                    }
                );
              }
          )
        },
        tooltip: 'Todoを追加',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TodoListWidget extends ConsumerWidget {
  const TodoListWidget({
    super.key,
    required this.todoList
  });

  final List<Todo> todoList;

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
                    onCardClick: (todo) => {
                      //todo: クリック処理を入れる。
                    },
                    onDoneClick: (todo) => {
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
