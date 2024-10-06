
import 'package:flutter/material.dart';

class DismissBackground extends StatelessWidget {
  const DismissBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        color: Colors.redAccent.shade100,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete),
            SizedBox(width: 8),
            Text(
              "削除",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16),
          ],
        )
    );
  }

}