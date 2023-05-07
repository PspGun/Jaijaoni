import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/model/debt.model.dart';
import 'package:jaijaoni/services/store/fire_store_service.dart';

Future<List<Debts>> findBorrowerByUserId() async {
  try {
    QuerySnapshot<Map<String, dynamic>> bowDoc = await FireStoreService
        .collection.borrowers
        .where("borrowerUserId",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    List<Borrowers> bows =
        bowDoc.docs.map((e) => Borrowers.fromFireStore(e)).toList();
    List<String> debtId = bows.map((e) => e.debtId).toList();
    // print(debtId);
    QuerySnapshot<Map<String, dynamic>> debtDoc = await FireStoreService
        .collection.debts
        .where(FieldPath.documentId, whereIn: debtId)
        .get();
    List<Debts> debts =
        debtDoc.docs.map((e) => Debts.fromFireStore(e)).toList();
    // print(debts.length);

    return debts;
  } catch (err) {
    rethrow;
  }
}
