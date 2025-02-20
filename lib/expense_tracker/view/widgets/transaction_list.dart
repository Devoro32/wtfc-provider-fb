import 'package:wtfc_provider_app/export.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider =
        Provider.of<expTrackerTractionProvider>(context);

    return ListView.builder(
      itemCount: transactionProvider.exptTransaction.length,
      itemBuilder: (ctx, index) {
        final tx = transactionProvider.exptTransaction[index];
        return GestureDetector(
          onLongPress: () {
            transactionProvider.exptRemoveTransaction(tx.id);
          },
          child: ListTile(
            title: Text(tx.title),
            subtitle: Text(tx.date.toString()),
            trailing: Text(
              '\$${tx.amount.toStringAsFixed(2)}',
              style: TextStyle(
                color: tx.isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
