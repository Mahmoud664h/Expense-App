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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Expense Tracker')),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (c) => const NewExpense(),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('.....'),
            Expanded(
              child: ExpensesList(expenses: _registeredExpenses),
            )
          ],
        ),
      ),
    );
  }
}
