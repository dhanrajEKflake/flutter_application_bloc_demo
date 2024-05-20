import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/meal_screen/bloc/meal_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MealDetails extends StatelessWidget {
  MealDetails({super.key, required this.mealId});
  final int mealId;
  final MealDetailsBloc mealDetailsBloc = MealDetailsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: BlocProvider(
        create: (context) =>
            mealDetailsBloc..add(MealFetchDetailsEvent(mealId: mealId)),
        child: BlocConsumer<MealDetailsBloc, MealDetailsState>(
            buildWhen: ((previous, current) =>
                current is MealDetailsSuccessState ||
                current is MealDetailsLoadingState),
            listenWhen: ((previous, current) =>
                current is! MealDetailsSuccessState),
            builder: (context, state) {
              if (state is MealDetailsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is MealDetailsSuccessState) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(state
                                          .mealData.meals!.first.strMealThumb
                                          .toString()))),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  mealDetailsBloc.add(
                                      MealDetailsPlayButtonPressedEvent(
                                          youtubeURL: state
                                              .mealData.meals!.first.strYoutube
                                              .toString()));
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black26),
                                  child: const Center(
                                    child: Icon(Icons.play_arrow),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            state.mealData.meals!.first.strMeal.toString(),
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Text(
                                "${state.mealData.meals!.first.strCategory},",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "from - ${state.mealData.meals!.first.strArea}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: RichText(
                            text: TextSpan(
                                text: 'Instructions: ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          '${state.mealData.meals!.first.strInstructions}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400))
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: RichText(
                            text: TextSpan(
                                text: 'Ingredient: ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          '${state.mealData.meals!.first.strIngredient1}, ${state.mealData.meals!.first.strIngredient2}, ${state.mealData.meals!.first.strIngredient3}, ${state.mealData.meals!.first.strIngredient4}, ${state.mealData.meals!.first.strIngredient5}, ${state.mealData.meals!.first.strIngredient6}, ${state.mealData.meals!.first.strIngredient7}, ${state.mealData.meals!.first.strIngredient8}, ${state.mealData.meals!.first.strIngredient9}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400))
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {
              if (state is MealDetailsErrorState) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog.adaptive(
                          title: Text(state.message),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'))
                          ],
                        ));
              }
              if (state is MealDetailsPlayVideoState) {
                YoutubePlayerController controller = YoutubePlayerController(
                  initialVideoId: state.youtubeId,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    mute: true,
                  ),
                );

                showGeneralDialog(
                    context: context,
                    pageBuilder: ((context, animation, secondaryAnimation) {
                      return YoutubePlayerBuilder(
                          player: YoutubePlayer(controller: controller),
                          builder: (context, player) {
                            return Container(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 20),
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            controller.dispose();
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  player,
                                  const Spacer(
                                    flex: 2,
                                  ),
                                ],
                              ),
                            );
                          });
                    }));
              }
            }),
      ),
    );
  }
}
