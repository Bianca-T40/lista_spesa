import 'package:flutter/material.dart';
import '../models/item.dart';
import '../constants/categorie.dart';

class ShoppingListTile extends StatelessWidget {
  final Item item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ShoppingListTile({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colore = coloriCategoria[item.categoria] ?? Colors.grey;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: colore, radius: 8),
        title: Text(
          item.nome,
          style: TextStyle(
            decoration: item.comprato == 1 ? TextDecoration.lineThrough : null,
            color: item.comprato == 1 ? Colors.grey : null,
          ),
        ),
        subtitle: Text(item.categoria),
        trailing: Checkbox(
          value: item.comprato == 1,
          onChanged: (_) => onToggle(),
        ),
        onTap: onToggle,
      ),
    );
  }
}
