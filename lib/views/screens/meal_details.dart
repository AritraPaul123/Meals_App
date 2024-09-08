import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import '../../models/meals.dart';

class MealDetails extends ConsumerWidget{
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals=ref.watch(favoriteMealsProvider);
    var isFavorite=favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: (){
            final wasAdded=ref.read(favoriteMealsProvider.notifier).toggleFavoritesStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            if(wasAdded){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Meal added to Favorites!")));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Meal is not favorite anymore.")));
            }
          }, icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation){
                return RotationTransition(turns: Tween<double>(begin: 0.8, end: 1).animate(animation), child: child);
              },
              child: Icon(isFavorite? Icons.star : Icons.star_border, key: ValueKey(isFavorite),))),
          const SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: ValueKey(meal.id),
              child: Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "Ingredients",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 14),
            for (var ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            const SizedBox(height: 14),
            Text(
              "Steps",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 14),
            for (var step in meal.steps)
              Text(
                step,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
          ],
        ),
      ),
    );
  }
}
