import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/database_helper.dart';
import '../widgets/add_item_dialog.dart';
import '../widgets/shopping_list_tile.dart';

// Questa è la schermata principale. Si occupa di:
// 1. Tenere lo stato della lista (_items)
// 2. Parlare con il database tramite DatabaseHelper
// 3. Assemblare la UI usando i widget già pronti (ShoppingListTile, dialog)
//
// Non contiene più i dettagli di "come è fatta una riga" o "come è fatto
// il form di aggiunta": quelli sono in widgets/.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Item> _items = [];

  @override
  void initState() {
    super.initState();
    _caricaItems();
  }

  // Legge tutti gli articoli dal database e aggiorna la UI
  Future<void> _caricaItems() async {
    final items = await _dbHelper.getItems();
    setState(() {
      _items = items;
    });
  }

  // Aggiunge un nuovo articolo e ricarica la lista
  Future<void> _aggiungiItem(String nome, String categoria) async {
    final nuovoItem = Item(nome: nome, categoria: categoria);
    await _dbHelper.insertItem(nuovoItem);
    _caricaItems();
  }

  // Cambia lo stato "comprato" di un articolo
  Future<void> _toggleComprato(Item item) async {
    final aggiornato = item.copyWith(comprato: item.comprato == 0 ? 1 : 0);
    await _dbHelper.updateItem(aggiornato);
    _caricaItems();
  }

  // Elimina un articolo dato il suo id
  Future<void> _eliminaItem(int id) async {
    await _dbHelper.deleteItem(id);
    _caricaItems();
  }

  @override
  Widget build(BuildContext context) {
    final totale = _items.length;
    final comprati = _items.where((item) => item.comprato == 1).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('La mia spesa'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              totale == 0 ? 'Nessun articolo' : '$comprati di $totale comprati',
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'La lista è vuota.\nPremi + per aggiungere un articolo.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ShoppingListTile(
                  item: item,
                  onToggle: () => _toggleComprato(item),
                  onDelete: () => _eliminaItem(item.id!),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => mostraDialogAggiungiArticolo(
          context: context,
          onAdd: _aggiungiItem,
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
