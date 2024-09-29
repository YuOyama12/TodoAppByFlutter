import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todo_app_flutter/model/todo/todo.dart';

class TodoCard extends ConsumerWidget {
  const TodoCard({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    required this.todo,
    required this.onCardClick,
    required this.onDoneClick
  });

  final EdgeInsets padding;
  final Todo todo;
  final Function(Todo) onCardClick;
  final Function(Todo) onDoneClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () => onCardClick(todo),
      child: Padding(
        padding: padding,
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

