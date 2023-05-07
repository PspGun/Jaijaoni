import 'dart:math';

import 'package:jaijaoni/functions/utils/find_borrower_debt_user_by_id.dart';
import 'package:jaijaoni/model/borrower.model.dart';
import 'package:jaijaoni/model/debt.model.dart';

class BorrowerData {
  final String id;
  final String debtid;
  final String username;
  final double total;
  BorrowerData(
      {required this.id,
      required this.debtid,
      required this.username,
      required this.total});
}

Future<BorrowerData> getBorrower(String debtId) async {
  try {
    Borrowers borrower = await findborrwerBytwoId(debtId);

    return BorrowerData(
        id: borrower.borrowId,
        debtid: borrower.debtId,
        username: borrower.borrowerUsername,
        total: borrower.debtRemaining);
  } catch (err) {
    // print("catch2");
    // print(err.toString());
    rethrow;
  }
}
