import 'package:flutter/material.dart';
import 'package:flutter_meal_app/data/dummy_data.dart';
import 'package:flutter_meal_app/model/category.dart';
import 'package:flutter_meal_app/screens/meals.dart';

import '../model/meals.dart';
import '../widgets/categroy_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1, //these are default values
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Catagory category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    ); // Navigator.push(context, route)
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectedCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
        builder: (context, child) => SlideTransition(
position:Tween(
  begin:const Offset(0, 0.3),end: const Offset(0, 0)
).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
              // padding: EdgeInsets.only(
              //   top:100- _animationController.value * 100,
              // ),
              child: child,
            ));
  }
}

















// class CategoryScreen extends StatelessWidget {
//   const CategoryScreen({super.key, required this.onToggleFavorite, required availableMeals});

//   final void Function(Meal meal) onToggleFavorite;

//   void _selectCategory(BuildContext context, Catagory category) {
//     final filteredMeals = dummyMeals
//         .where((Meal) => Meal.categories.contains(category.id))
//         .toList();

//     Navigator.of(context).push(MaterialPageRoute(
//         builder: (ctx) => MealsScreen(
//               meals: filteredMeals,
//               title: category.title,
//               onToggleFavorite: onToggleFavorite,
//             )));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView(
//       padding: const EdgeInsets.all(24),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 3 / 2,
//           crossAxisSpacing: 20,
//           mainAxisSpacing: 20),
//       children: [
//         for (final category in availableCategories)
//           CategoryGridItem(
//             category: category,
//             onSelectedCategory: () {
//               _selectCategory(context, category);
//             },
//           )
//       ],
//     );
//   }
// }
