import 'package:flutter/material.dart';
import 'package:flutter_meal_app/screens/meal_detail_screen.dart';

import '../model/meals.dart';
import '../widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, this.title,});

  final String? title;
  final List<Meal> meals;


  void selectMeal(BuildContext context, Meal meal) {
    // Navigator.pop(context);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal,  )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (ctx, meal) {
                selectMeal(context, meal);
              },
            ));
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('oops!... Nothing Here'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try Selecting a Different Category!',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            )
          ],
        ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
        appBar: AppBar(
          title:  Text(title!),
        ),
        body: content);
  }
}
