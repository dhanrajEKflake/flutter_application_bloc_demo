import 'package:flutter_application_bloc_demo/modal/meal_modal.dart';
import 'package:flutter_application_bloc_demo/services/exception/exception.dart';
import 'package:flutter_application_bloc_demo/services/repo/meals/meal_repo.dart';
import 'package:flutter_application_bloc_demo/services/services.dart';

class MealRepoImpl implements MealRepo {
  @override
  Future<MealResponseModal> getrandomMealData() async {
    // TODO: implement getrandomMealData
    // throw UnimplementedError();
    try {
      var response = await apiService.get(path: 'random.php');
      if (response.statusCode == 200) {
        MealResponseModal mealResponse =
            MealResponseModal.fromJson(response.data);
        return mealResponse;
      }
      return {} as MealResponseModal;
    } catch (e) {
      throw RepoException(e.toString());
    }
  }

  @override
  Future<MealResponseModal> getDetailMealData({int? mealId}) async {
    // TODO: implement getDetailMealData
    // throw UnimplementedError();
    try {
      var response =
          await apiService.get(path: 'lookup.php', query: {"i": mealId});
      if (response.statusCode == 200) {
        MealResponseModal mealResponse =
            MealResponseModal.fromJson(response.data);
        return mealResponse;
      }
      return {} as MealResponseModal;
    } catch (e) {
      throw RepoException(e.toString());
    }
  }
}
