import 'package:wtfc_provider_app/expense_tracker/view/widgets/transaction_list.dart';
import 'package:wtfc_provider_app/export.dart';

class ExpenseTrackerScreen extends StatelessWidget {
  const ExpenseTrackerScreen({super.key});
//!https://youtu.be/scH4t0xEAM4?list=PLOEXB48nQMqOeH-s-VlhssETHfG-DYx5S
//! github: https://github.com/Nabinji/Flutter_Provider/tree/main/lib/Voting%20App
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
      ),
      body: const Column(
        children: [
          SummaryCard(),
          Expanded(
            child: TransactionList(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => const expAddTransaction());
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
