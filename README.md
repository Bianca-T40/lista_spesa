# Lista Spesa - Progetto Flutter

App mobile per gestire la lista della spesa, sviluppata in Flutter/Dart
con database locale SQLite (tramite il pacchetto `sqflite`).

Repository: https://github.com/Bianca-T40/lista_spesa

## Struttura dei file

```
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

assets/
└── icon/
    └── icon.png                   → sorgente dell'icona dell'app (1024x1024)
```

## Come avviarlo da zero

1. Clona il repository (o scarica lo ZIP da GitHub):
   ```
   git clone https://github.com/Bianca-T40/lista_spesa.git
   ```
2. Installa le dipendenze:
   ```
   flutter pub get
   ```
3. Avvia l'app su un emulatore o dispositivo (F5 in VS Code, oppure):
   ```
   flutter run
   ```

Se hai scaricato/clonato il progetto su un PC diverso da quello originale,
lancia anche `flutter clean` prima di `flutter pub get`, per evitare
problemi di cache tra macchine diverse.

## Icona e nome dell'app

L'app si chiama **Lista Spesa** e ha un'icona personalizzata (carrello con
frutta e verdura), generata a partire da un'unica immagine sorgente tramite
il pacchetto `flutter_launcher_icons`.

- Immagine sorgente: `assets/icon/icon.png`
- Configurazione in `pubspec.yaml`:
  ```yaml
  dev_dependencies:
    flutter_launcher_icons: ^0.13.1

  flutter_launcher_icons:
    android: true
    ios: true
    image_path: "assets/icon/icon.png"
  ```
- Comando per rigenerare le icone dopo aver cambiato l'immagine sorgente:
  ```
  dart run flutter_launcher_icons
  ```
- Il nome visibile sotto l'icona si cambia in
  `android/app/src/main/AndroidManifest.xml`, proprietà `android:label`.

## Perché questa struttura del codice

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
- Dopo aver cambiato icona o nome, conviene rilanciare `flutter clean`
  prima di reinstallare l'app, altrimenti il launcher del telefono a
  volte mantiene in cache l'icona/nome precedenti.

## Funzionalità già implementate

- Aggiungere un articolo (nome + categoria) tramite dialog
- Segnare/deselezionare un articolo come "comprato" (checkbox o tap)
- Eliminare un articolo con swipe laterale
- Contatore "X di Y comprati" aggiornato in tempo reale
- Pallino colorato per ogni categoria
- Icona e nome dell'app personalizzati

## Idee per rifiniture future, se hai tempo

- Aggiungere un campo "quantità" (colonna nella tabella + TextField nel
  dialog)
- Cambiare le categorie in `constants/categorie.dart`
- Aggiungere un'icona diversa per ogni categoria invece del pallino colorato
- Liste multiple, storico degli acquisti, tema scuro (vedi presentazione)