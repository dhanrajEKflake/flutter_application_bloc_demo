import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/cart/cart.dart';
import 'package:flutter_application_bloc_demo/dropdownscreen/dropdownscreen.dart';
import 'package:flutter_application_bloc_demo/home/bloc/home_bloc.dart';
import 'package:flutter_application_bloc_demo/home/widgets/fruit_tile_widget.dart';
import 'package:flutter_application_bloc_demo/meal_screen/meal_screen.dart';
import 'package:flutter_application_bloc_demo/pagination_list/pagination_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeLoadFruitsDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DropDownScreen()));
                },
                icon: const Icon(Icons.arrow_circle_down_rounded)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaginationScreen()));
                },
                icon: const Icon(Icons.list)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MealScreen()));
                },
                icon: const Icon(Icons.no_food)),
            IconButton(
                onPressed: () {
                  homeBloc.add(HomeNavigateToCartEvent());
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
            listenWhen: ((previous, current) => current is! HomeSuccessState),
            buildWhen: (((previous, current) =>
                current is HomeSuccessState || current is HomeLoadingState)),
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              if (state is HomeSuccessState) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Welcome: ${homeBloc.user!.email}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {
                            homeBloc.user!.emailVerified
                                ? null
                                : homeBloc.add(HomeVerifyEmailEvent());
                          },
                          child: Text(homeBloc.user!.emailVerified
                              ? '--Verified--'
                              : '--Verify?--'),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.fruitsList.length,
                          itemBuilder: (context, index) {
                            return FruitTileWidget(
                              myFruit: state.fruitsList[index],
                              onTapFavIcon: () {
                                homeBloc.add(HomeErrorEvent());
                              },
                              onTapCartIcon: () {
                                debugPrint('tappped');
                                homeBloc.add(HomeAddtoCartEvent(
                                    myFruit: state.fruitsList[index]));
                              },
                            );
                          }),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {
              if (state is HomeErrorState) {
                ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
                    backgroundColor: Colors.red,
                    content: Text(
                      state.message,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          },
                          child: const Text(
                            'Dismiss',
                            style: TextStyle(color: Colors.red),
                          )),
                    ]));
              } else if (state is HomeAddedtoCartState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is HomeNavigateToCartState) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Cart()));
              }
            }),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              homeBloc.add(HomeLogoutEvent());
            },
            label: const Text('Log out')),
      ),
    );
  }
}
