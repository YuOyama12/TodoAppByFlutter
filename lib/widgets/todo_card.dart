import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app_flutter/model/todo/todo.dart';
import 'package:todo_app_flutter/widgets/confirmation_dialog.dart';
import 'package:todo_app_flutter/widgets/dismiss_background.dart';

class TodoCard extends ConsumerWidget {
  const TodoCard({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    required this.todo,
    required this.onCardClick,
    required this.onCardDelete,
    required this.onDoneClick
  });

  final EdgeInsets padding;
  final Todo todo;
  final Function(Todo) onCardClick;
  final Function(Todo) onCardDelete;
  final Function(Todo) onDoneClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => onCardClick(todo),
      child: Padding(
        padding: padding,
        child: Dismissible(
            key: ObjectKey(todo),
            direction: DismissDirection.endToStart,
            background: const DismissBackground(),
            confirmDismiss: (_) async {
              final result = showConfirmationDialog(
                  context: context,
                  dialogTitle: "削除の確認",
                  dialogMessage: "削除するともとに戻すことはできません。本当に削除しますか？",
                  positiveButtonText: "削除",
                  onPositiveClick: () { onCardDelete(todo); }
              );

              return result;
            },
            child: Card(
              child: InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            todo.title,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 18.0
                            ),
                          ),
                          const Spacer(),
                          DoneButton(onPressed: () => onDoneClick(todo))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                          todo.description,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        )
      ),
    );
  }
}

class DoneButton extends ConsumerWidget {
  const DoneButton({
    super.key,
    required this.onPressed
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
              CircleBorder()
          ),
          side: WidgetStatePropertyAll(
              BorderSide(color: Colors.grey)
          )
        ),
    );
  }

}

