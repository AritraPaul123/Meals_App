import 'package:flutter/material.dart';
import 'package:meals_app/views/screens/meal_details.dart';
import 'package:meals_app/views/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../models/meals.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MealDetails(meal: meal)));
        },
        child: Stack(
          children: [
            Hero(
              tag: ValueKey(meal.id),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                height: 300,
                width: double.infinity,
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                            icon: Icons.schedule,
                            label: "${meal.duration} mins"),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.work,
                            label:
                                "${meal.complexity.name[0].toUpperCase()}${meal.complexity.name.substring(1, meal.complexity.name.length)}"),
                        const SizedBox(width: 12),
                        MealItemTrait(
                            icon: Icons.attach_money,
                            label:
                                "${meal.affordability.name[0].toUpperCase()}${meal.affordability.name.substring(1, meal.affordability.name.length)}"),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
