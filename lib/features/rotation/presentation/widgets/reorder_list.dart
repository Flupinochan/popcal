import 'package:flutter/material.dart';

class ReorderList extends StatelessWidget {
  final List<String> items;
  final Function(int, int) onReorder;
  final Function(int) onDelete;

  const ReorderList({
    super.key,
    required this.items,
    required this.onReorder,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return SizedBox.shrink();

    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      onReorder: onReorder,
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(items[index]),
          margin: EdgeInsets.only(bottom: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey[300]!),
          ),
          child: ListTile(
            leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            title: Text(items[index]),
            trailing: IconButton(
              icon: Icon(Icons.close, color: Colors.red, size: 20),
              onPressed: () => onDelete(index),
            ),
          ),
        );
      },
    );
  }
}
