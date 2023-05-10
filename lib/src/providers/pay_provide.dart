import 'package:flutter/material.dart';

class PayProvider with ChangeNotifier {
  List<String> fotos = [];
  String uidEvento = "";
  Future<void> setFotos(String urlPhoto) async {
    fotos.add(urlPhoto);
    notifyListeners();
  }

  Future<void> setUidEvento(String uidEvento) async {
    this.uidEvento = uidEvento;
    notifyListeners();
  }
  Future<void> vaciarPhotos() async {
    fotos = [];
    notifyListeners();
  }
}
