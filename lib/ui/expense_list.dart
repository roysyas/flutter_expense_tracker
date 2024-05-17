import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense_model.dart';
import 'package:flutter_expense_tracker/ui/expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenseData, required this.onRemove});

  final List<ExpenseModel> expenseData;
  final void Function(ExpenseModel expenseModel) onRemove;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenseData.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ValueKey(expenseData[index]),
          onDismissed: (direction) {
            onRemove(expenseData[index]);
          },
          child: ExpenseItem(
            expenseItem: expenseData[index],
          ),
        ),
      ),
    );
  }
}
