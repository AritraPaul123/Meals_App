import 'package:flutter/material.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/views/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    Widget content;
    if(meals.isEmpty){
      content=Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Uh oh ... nothing here!", style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface)),
            const SizedBox(height: 10,),
            Text("Try selecting a different category", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface))
          ],
        ),
      );
    }else{
      content=ListView.builder(
        itemCount: meals.length,
          itemBuilder: (content, index){
          return MealItem(meal: meals[index]);
          }
      );
    }
    return Scaffold(
      appBar: title!=null ? AppBar(
        title: Text(title!),
      ) : null,
      body: content,
    );
  }
}
