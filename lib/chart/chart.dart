import 'package:expenses/chart/chart_bar.dart';
import 'package:expenses/modles/expense.dart';
import 'package:expenses/widgets/expenses.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});
  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(allExpenses: expenses, category: Category.food),
      ExpenseBucket.forCategory(
          allExpenses: expenses, category: Category.leisure),
      ExpenseBucket.forCategory(
          allExpenses: expenses, category: Category.travel),
      ExpenseBucket.forCategory(allExpenses: expenses, category: Category.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (var element in buckets) {
      if (element.totalExpenses > maxTotalExpense) {
        maxTotalExpense = element.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      height: 175,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: (255 * 0.3).toDouble()),
            Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: (255 * 0.0).toDouble()),
          ])),
      child: Column(
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final ele in buckets)
                ChartBar(
                  fill: ele.totalExpenses == 0
                      ? 0
                      : ele.totalExpenses / maxTotalExpense,
                ),
            ],
          )),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: buckets
                .map((e) => Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcon[e.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: (255 * 0.7).toDouble()),
                      ),
                    )))
                .toList(),
          )
        ],
      ),
    );
  }
}
