import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.positiveButtonText,
    this.cancelButtonText,
    required this.onPositiveClick,
    this.onCancelClick
  });

  final String title;
  final String message;
  final String positiveButtonText;
  final String? cancelButtonText;
  final Function() onPositiveClick;
  final Function()? onCancelClick;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            if (onCancelClick != null) {
              onCancelClick!();
            }
            Navigator.of(context).pop(false);
          },
          child: Text(cancelButtonText ?? "キャンセル"),
        ),
        TextButton(
            onPressed: () {
              onPositiveClick();
              Navigator.of(context).pop(true);
            },
            child: Text(positiveButtonText)
        )
      ],
    );
  }
}


Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String dialogTitle,
    required String dialogMessage,
    required String positiveButtonText,
    String? cancelButtonText,
    required Function() onPositiveClick,
    Function()? onCancelClick
}) async {
  return showDialog<bool>(
      context: context,
      builder: (_) {
        return ConfirmationDialog(
            title: dialogTitle,
            message: dialogMessage,
            positiveButtonText: positiveButtonText,
            cancelButtonText: cancelButtonText,
            onPositiveClick: onPositiveClick,
            onCancelClick: onCancelClick,
        );
      }
  );
}