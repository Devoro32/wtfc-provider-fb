import 'package:wtfc_provider_app/export.dart';

class expAddTransaction extends StatefulWidget {
  const expAddTransaction({super.key});

  @override
  State<expAddTransaction> createState() => _expAddTransactionState();
}

class _expAddTransactionState extends State<expAddTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isIncome = true;
  void submitData() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text) ?? 0;

    if (title.isEmpty || amount <= 0) return;
    Provider.of<expTrackerTractionProvider>(context, listen: false)
        .exptAddTransaction(title, amount, _isIncome);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Title"),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: "Amount"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Income",
                style: TextStyle(
                  color: _isIncome == true ? Colors.green : Colors.black,
                ),
              ),
              Switch(
                  value: _isIncome,
                  onChanged: (val) {
                    setState(() {
                      _isIncome = val;
                    });
                  }),
              Text(
                "Expense",
                style: TextStyle(
                  color: _isIncome == false ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: submitData,
                child: Text("Add Transaction"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
