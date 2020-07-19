import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('colegios')
        .where('businessName',
            isGreaterThanOrEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
