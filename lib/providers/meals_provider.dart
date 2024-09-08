import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/constants.dart';

final mealsProvider=Provider((ref){
  return dummyMeals;
});