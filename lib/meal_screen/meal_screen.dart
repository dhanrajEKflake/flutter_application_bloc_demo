import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/meal_screen/bloc/meal_bloc.dart';
import 'package:flutter_application_bloc_demo/meal_screen/meal_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealScreen extends StatelessWidget {
  MealScreen({super.key});
  final MealBloc mealBloc = MealBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white38,
        title: const Text('Random Meal'),
      ),
      body: BlocProvider(
        create: (context) => mealBloc..add(MealFetchDataEvent()),
        child: BlocConsumer<MealBloc, MealState>(
            buildWhen: ((previous, current) =>
                current is MealSuccessState || current is MealLoadingState),
            listenWhen: ((previous, current) => current is! MealSuccessState),
            builder: (context, state) {
              if (state is MealLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MealSuccessState) {
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: double.maxFinite,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         fit: BoxFit.cover,
                      //         image: NetworkImage(state
                      //             .mealData.meals![0].strMealThumb
                      //             .toString()))),
                      child: FancyShimmerImage(
                          shimmerBaseColor: Colors.orange.shade200,
                          shimmerHighlightColor: Colors.orange.shade400,
                          shimmerBackColor: Colors.orange,
                          boxFit: BoxFit.cover,
                          imageUrl:
                              state.mealData.meals![0].strMealThumb.toString()),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 10,
                      right: 10,
                      child: Container(
                        // width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(8)),

                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    state.mealData.meals![0].strMeal
                                            .toString() *
                                        10,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  " -${state.mealData.meals![0].strCategory}",
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Text(
                              "From: ${state.mealData.meals![0].strArea}",
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MealDetails(
                                                mealId: int.parse(state
                                                    .mealData.meals![0].idMeal
                                                    .toString()),
                                                // mealId: 0,
                                              )));
                                },
                                child: const Text('Details'))
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {
              if (state is MealErrorState) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                          title: Text('Error: ${state.message}'),
                        ));
              }
            }),
      ),
    );
  }
}
