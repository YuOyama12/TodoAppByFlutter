import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddTodoDialog extends HookConsumerWidget {
  const AddTodoDialog({
    super.key,
    required this.onAddClick,
  });

  final Function(String, String) onAddClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTitle = useState("");
    final todoDescription = useState("");

    return SimpleDialog(
      title: const Text("Todoの追加"),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Todoのタイトルを入力してください。",
                  style: TextStyle(
                      color: Colors.blueGrey
                  ),
                  textAlign: TextAlign.left,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: '例）〇〇をする',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => todoTitle.value = text,
              autofocus: true,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Todoの内容を入力してください。",
                  style: TextStyle(
                    color: Colors.blueGrey
                  ),
                  textAlign: TextAlign.left,
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => todoDescription.value = text,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: (){ Navigator.of(context).pop(); },
                child: const Text("キャンセル")
            ),
            const SizedBox(width: 12.0),
            TextButton(
                onPressed: todoTitle.value.isEmpty ? null
                    : () {
                  onAddClick(todoTitle.value, todoDescription.value);
                  Navigator.of(context).pop();
                },
                child: const Text("追加")
            ),
          ],
        )
      ],
    );
  }
}