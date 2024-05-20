import 'package:flutter_application_bloc_demo/modal/meal_modal.dart';

abstract class MealRepo {
  Future<MealResponseModal> getrandomMealData();
  Future<MealResponseModal> getDetailMealData({int mealId});
}
