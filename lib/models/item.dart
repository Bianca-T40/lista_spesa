// Rappresenta un singolo articolo della lista della spesa.
// Questa classe serve solo per passare i dati in modo ordinato
// tra database e interfaccia.
class Item {
  final int? id; // null finché non è ancora salvato nel database
  final String nome;
  final String categoria;
  final int comprato; // 0 = da comprare, 1 = comprato (SQLite non ha booleani)

  Item({
    this.id,
    required this.nome,
    required this.categoria,
    this.comprato = 0,
  });

  // Converte l'oggetto in una Map, formato richiesto da sqflite
  // per salvare i dati nel database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'comprato': comprato,
    };
  }

  // Crea un oggetto Item a partire da una riga letta dal database.
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      nome: map['nome'],
      categoria: map['categoria'],
      comprato: map['comprato'],
    );
  }

  // Utile per creare una copia dell'oggetto cambiando solo alcuni campi
  // (es. quando spunto il checkbox "comprato")
  Item copyWith({int? id, String? nome, String? categoria, int? comprato}) {
    return Item(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      categoria: categoria ?? this.categoria,
      comprato: comprato ?? this.comprato,
    );
  }
}
