import 'package:expenses/chart/chart.dart';
import 'package:expenses/modles/expense.dart';
import 'package:expenses/widgets/expanses_list/expanses_list.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        category: Category.work,
        title: 'Flutter Course',
        amount: 20.0,
        date: DateTime.now()),
    Expense(
        category: Category.leisure,
        title: 'Cinma',
        amount: 30.0,
        date: DateTime.now()),
    Expense(
        category: Category.food,
        title: 'Breakfast',
        amount: 40.0,
        date: DateTime.now())
  ];
  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Espenses found'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Expense Tracker')),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => NewExpense(
                    onAddExpense: addExpense,
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: mainContent,
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(
                    child: mainContent,
                  )
                ],
              ),
      ),
    );
  }
}
