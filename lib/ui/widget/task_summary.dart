import 'package:flutter/material.dart';

class TaskSummary extends StatelessWidget {
  const TaskSummary({
    super.key, required this.count, required this.title,
  });
  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(count, style: Theme.of(context).textTheme.titleLarge,),
            Text(title )
          ],
        ),
      ),
    );
  }
}