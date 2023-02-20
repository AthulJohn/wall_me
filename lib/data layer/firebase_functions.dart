import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseFunctions {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<bool> addNote(
      String siteUrl, List<Map<String, dynamic>> datas) async {
    final siteRef = db.collection("sites").doc(siteUrl);
    bool hasSite = false;
    try {
      await db.runTransaction((transaction) async {
        final snapshot = await transaction.get(siteRef);
        if (snapshot.exists) {
          hasSite = true;
          return;
        }
        transaction
            .set(siteRef, {"url": siteUrl, "userId": "admin", "views": 0});

        for (Map<String, dynamic> data in datas) {
          transaction.set(
              siteRef.collection("0").doc("${data['noteId']}"), data);
        }
      }).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"),
      );

      print("added");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> updateNote(
      String collection, String docId, Map<String, dynamic> data) {
    return db.collection(collection).doc(docId).update(data);
  }

  static Future<void> deleteNote(
      String collection, String docId, Map<String, dynamic> data) {
    return db.collection(collection).doc(docId).delete();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>?> firebaseGetSite(
      String siteUrl) async {
    QuerySnapshot<Map<String, dynamic>>? data;
    try {
      await db.runTransaction((transaction) async {
        final snapshot =
            await transaction.get(db.collection('sites').doc(siteUrl));

        if (snapshot.exists) {
          data = await snapshot.reference.collection("0").get();

          transaction.update(db.collection('sites').doc(siteUrl),
              {"views": snapshot.data()!["views"] + 1});
        }
      });
    } catch (e) {
      print(e);
    }
    return data;
  }
}
