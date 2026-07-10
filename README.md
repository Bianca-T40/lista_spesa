# Lista della spesa - Progetto Flutter

App mobile per gestire la lista della spesa, sviluppata in Flutter/Dart
con database locale SQLite (tramite il pacchetto `sqflite`).

## Struttura dei file

lib/
├── main.dart                      → avvio app (solo runApp)
├── app.dart                       → MaterialApp, tema, titolo
├── models/
│   └── item.dart                  → modello dati Item
├── services/
│   └── database_helper.dart       → tutte le funzioni per il database
├── constants/
│   └── categorie.dart             → elenco categorie e colori
├── screens/
│   └── home_screen.dart           → schermata principale (lista + stato)
└── widgets/
    ├── add_item_dialog.dart       → dialog per aggiungere un articolo
    └── shopping_list_tile.dart    → singola riga della lista


## Come avviarlo da zero

1. Crea un nuovo progetto Flutter (se non l'hai già fatto):
   ```
   flutter create lista_spesa
   ```
2. Dentro `lib/`, crea le sottocartelle `models`, `services`, `constants`,
   `screens`, `widgets` e copia ogni file al posto giusto, rispettando
   esattamente i nomi (servono per gli `import` tra i file).
3. Apri `pubspec.yaml` e aggiungi sotto `dependencies:` (allineato con
   `flutter:`, non con `sdk:`):
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     sqflite: ^2.3.0
     path: ^1.9.0
   ```
4. Installa le dipendenze:
   ```
   flutter pub get
   ```
5. Avvia l'app su un emulatore o dispositivo (F5 in VS Code, oppure):
   ```
   flutter run
   ```

## Perché questa struttura

Ogni file ha UNA responsabilità sola:
- `item.dart` → solo il modello dati, nessuna logica
- `database_helper.dart` → solo query al database, nessuna UI
- `categorie.dart` → solo le costanti condivise (categorie/colori),
  così se vuoi aggiungere una categoria lo fai in un solo punto
- `add_item_dialog.dart` e `shopping_list_tile.dart` → pezzi di UI
  riutilizzabili, isolati dalla logica della schermata
- `home_screen.dart` → "collante" che tiene lo stato e assembla i pezzi
- `main.dart` e `app.dart` → solo avvio e configurazione, niente logica

Utile anche in fase di presentazione: puoi spiegare ogni file singolarmente
seguendo questo stesso ordine (modello → database → costanti → UI).

## Note importanti

- **SQLite su desktop/web**: `sqflite` funziona nativamente su Android e
  iOS. Se vuoi testare su Windows/Linux/macOS/Web serve un pacchetto
  aggiuntivo (`sqflite_common_ffi`). Con un emulatore Android o telefono
  fisico non serve cambiare nulla.
- Il database si chiama `lista_spesa.db` e viene creato automaticamente
  al primo avvio, non serve fare nulla a mano.
- Ogni dispositivo (telefono, emulatore) ha il proprio database locale,
  separato dagli altri: i dati non si sincronizzano automaticamente.

## Funzionalità già implementate

- Aggiungere un articolo (nome + categoria) tramite dialog
- Segnare/deselezionare un articolo come "comprato" (checkbox o tap)
- Eliminare un articolo con swipe laterale
- Contatore "X di Y comprati" aggiornato in tempo reale
- Pallino colorato per ogni categoria

## Idee per rifiniture future, se hai tempo

- Aggiungere un campo "quantità" (colonna nella tabella + TextField nel
  dialog)
- Cambiare le categorie in `constants/categorie.dart`
- Aggiungere un'icona diversa per ogni categoria invece del pallino colorato
- Liste multiple, storico degli acquisti, tema scuro (vedi presentazione)
