import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/expense_model.dart';
import 'package:flutter_expense_tracker/ui/add_expense.dart';
import 'package:flutter_expense_tracker/ui/chart/chart.dart';
import 'package:flutter_expense_tracker/ui/expense_list.dart';
import 'package:flutter_expense_tracker/models/category_enum.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() {
    return _Expense();
  }
}

class _Expense extends State<Expense> {
  final List<ExpenseModel> _registeredExpense = [
    ExpenseModel(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: 'Cinema',
      amount: 5.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: ((context) => AddExpense(
            onAddExpense: _addExpense,
          )),
    );
  }

  void _addExpense(ExpenseModel expenseModel) {
    setState(() {
      _registeredExpense.add(expenseModel);
    });
  }

  void _removeExpense(ExpenseModel expenseModel) {
    final expenseIndex = _registeredExpense.indexOf(expenseModel);
    setState(() {
      _registeredExpense.remove(expenseModel);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('expense deleted...'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expenseModel);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Expanded(
      child: Center(
        child: Text('empty list'),
      ),
    );

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenseData: _registeredExpense,
        onRemove: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registeredExpense,
          ),
          mainContent,
        ],
      ),
    );
  }
}
