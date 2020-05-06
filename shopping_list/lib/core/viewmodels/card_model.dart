import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_list/core/models/card.dart';
import 'package:shopping_list/core/services/card_service.dart';

import '../../locator.dart';

class CardCRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<CardData> cards;


  Future<List<CardData>> fetchCards() async {
    var result = await _api.getDataCollection();
    cards = result.documents
        .map((doc) => CardData.fromMap(doc.data, doc.documentID))
        .toList();
    return cards;
  }

  Stream<QuerySnapshot> fetchCardsAsStream() {
    return _api.streamDataCollection();
  }

  Future<CardData> getCardById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  CardData.fromMap(doc.data, doc.documentID) ;
  }


  Future removeCard(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateCard(CardData data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addCard(CardData data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;
  }

}