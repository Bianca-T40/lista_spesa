import 'package:flutter/material.dart';
import '../constants/categorie.dart';

// Mostra il dialog per aggiungere un nuovo articolo.
// Quando l'utente conferma, chiama onAdd passando nome e categoria scelti.
// Tenere questa funzione qui (invece che dentro home_screen.dart) separa
// la logica del "form di aggiunta" dalla logica della "lista principale".
void mostraDialogAggiungiArticolo({
  required BuildContext context,
  required void Function(String nome, String categoria) onAdd,
}) {
  final controllerNome = TextEditingController();
  String categoriaSelezionata = categorie.first;

  showDialog(
    context: context,
    builder: (context) {
      // StatefulBuilder serve per poter aggiornare il dropdown
      // dentro il dialog senza dover ricostruire tutta la schermata
      return StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Nuovo articolo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controllerNome,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Nome articolo'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: categoriaSelezionata,
                  decoration: const InputDecoration(labelText: 'Categoria'),
                  items: categorie.map((cat) {
                    return DropdownMenuItem(value: cat, child: Text(cat));
                  }).toList(),
                  onChanged: (valore) {
                    setDialogState(() {
                      categoriaSelezionata = valore!;
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Annulla'),
              ),
              FilledButton(
                onPressed: () {
                  final nome = controllerNome.text.trim();
                  if (nome.isEmpty) return; // non aggiungo articoli vuoti
                  onAdd(nome, categoriaSelezionata);
                  Navigator.pop(context);
                },
                child: const Text('Aggiungi'),
              ),
            ],
          );
        },
      );
    },
  );
}
