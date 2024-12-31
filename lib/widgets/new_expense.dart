import 'package:expenses/modles/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text('Amount'), prefixText: '\$'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'No Date selected'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: () async {
                              final now = DateTime.now();
                              final firstDate =
                                  DateTime(now.year - 1, now.month, now.day);
                              final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: now,
                                  firstDate: firstDate,
                                  lastDate: now);
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            },
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (newCat) {
                        if (newCat == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = newCat;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () {
                        final double? enteredAmount =
                            double.tryParse(_amountController.text);
                        final bool amountIsInvalid =
                            enteredAmount == null || enteredAmount <= 0;
                        if (_titleController.text.trim().isEmpty ||
                            amountIsInvalid ||
                            _selectedDate == null) {
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: const Text('Invalid input'),
                                    content: const Text(
                                        'please make surea valid title, amount, date and category'),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(ctx),
                                          child: const Text('Okay'))
                                    ],
                                  ));
                        } else {
                          widget.onAddExpense(Expense(
                              category: _selectedCategory,
                              title: _titleController.text,
                              amount: enteredAmount,
                              date: _selectedDate!));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
