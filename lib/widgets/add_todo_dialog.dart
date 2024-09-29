import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddTodoDialog extends HookConsumerWidget {
  const AddTodoDialog({
    super.key,
    required this.onAddClick,
  });

  final Function(String) onAddClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoTitle = useState("");

    return SimpleDialog(
      title: const Text("Todoの追加"),
      contentPadding: const EdgeInsets.all(16.0),
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Todoのタイトルを入力してください。"),
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: '例）〇〇をする',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) => todoTitle.value = text,
              autofocus: true,
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
                  onAddClick(todoTitle.value);
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