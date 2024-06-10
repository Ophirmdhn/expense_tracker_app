import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Flutter Course", 
      amount: 19.99, 
      date: DateTime.now(), 
      category: Category.work
    ),
    Expense(
      title: "Cinema", 
      amount: 15.69, 
      date: DateTime.now(), 
      category: Category.leisure
    ),
  ];

  void _openAddExpensesOverlay() { // membuka bottom sheet
    showModalBottomSheet(
      isScrollControlled: true, // membuat bottom sheet memenuhi layar
      context: context, 
      builder: (ctx) => NewExpense(onAddExpense: _addExpense)
    );
  }

  void _addExpense(Expense expense) { // menambahkan expense baru ke dalam list
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) { // menghapus expense
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar( // memunculkan snacbar ketiika menghapus expense
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Delete"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("Belum ada data pengeluaran"),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpensesOverlay, 
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: mainContent,
            )
          )
        ],
      ),
    );
  }
}