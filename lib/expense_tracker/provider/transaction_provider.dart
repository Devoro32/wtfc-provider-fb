import 'package:wtfc_provider_app/expense_tracker/model/transaction.dart';
import 'package:wtfc_provider_app/export.dart';

class expTrackerTractionProvider with ChangeNotifier {
  final List<expTrackerTransaction> _expTTransactions = [];

//getter for the transaction
  List<expTrackerTransaction> get exptTransaction => _expTTransactions;
  //for calculating the total income
  double get exptTotalIncome => _expTTransactions
      .where((tx) => tx.isIncome)
      .fold(0, (sum, tx) => sum + tx.amount);
  //for calculating the total expense
  double get exptTotalExpense => _expTTransactions
      .where((tx) => !tx.isIncome)
      .fold(0, (sum, tx) => sum + tx.amount);

  //for the new remaining balance
  double get remainingBalance => exptTotalIncome - exptTotalExpense;
//method to add a new transaction
  void exptAddTransaction(String title, double amount, bool isIncome) {
    final newTransaction = expTrackerTransaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      isIncome: isIncome,
    );
    //ensure that new transactions appears at the top
    _expTTransactions.insert(0, newTransaction);
  }

  //removing a transaction from the list by using the id
  void exptRemoveTransaction(String id) {
    _expTTransactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
