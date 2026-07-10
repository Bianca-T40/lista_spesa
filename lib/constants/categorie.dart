import 'package:flutter/material.dart';

// Elenco delle categorie disponibili per gli articoli.
// Per aggiungerne una nuova basta aggiungerla qui e alla mappa sotto.
const List<String> categorie = [
  'Frutta e Verdura',
  'Latticini',
  'Carne e Pesce',
  'Altro',
];

// Colore associato a ogni categoria, usato nel pallino colorato
// accanto a ogni articolo nella lista.
const Map<String, Color> coloriCategoria = {
  'Frutta e Verdura': Colors.green,
  'Latticini': Colors.amber,
  'Carne e Pesce': Colors.red,
  'Altro': Colors.blueGrey,
};
