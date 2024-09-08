import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meals.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>>{
  FavoritesNotifier() : super([]);

  bool toggleFavoritesStatus(Meal meal){
    final isExisting=state.contains(meal);
    if(isExisting){
      state=state.where((m)=>m.id!=meal.id).toList();
      return false;
    }else{
      state=[...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider=StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref){
  return FavoritesNotifier();
});