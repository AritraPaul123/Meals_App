import 'package:meals_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/constants.dart';
import 'package:meals_app/views/screens/meals_screen.dart';
import 'package:meals_app/views/widgets/category_grid_items.dart';

import '../../models/meals.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController=AnimationController(vsync: this, duration: const Duration(milliseconds: 300), lowerBound: 0, upperBound: 1);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MealsScreen(title: category.title, meals: filteredMeals)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 3 / 2),
            itemCount: availableCategories.length,
            itemBuilder: (context, index) => CategoryGridItems(
                  category: availableCategories[index],
                  onSelectedCategory: () {
                    _selectCategory(context, availableCategories[index]);
                  }
                )),
        builder: (context, child)=>SlideTransition(position: Tween(
            begin: const Offset(0.0, 0.3),
          end: const Offset(0.0, 0.0)
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)), child: child),
      ),
    );
  }
}
