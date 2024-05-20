import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/pagination_list/bloc/pagination_screen_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  late ScrollController scrollController;
  final PaginationScreenBloc paginationScreenBloc = PaginationScreenBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  fetchData() {
    paginationScreenBloc.add(PaginationScreenFetchDataEvent());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          paginationScreenBloc..add(PaginationScreenFetchDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagination demo app'),
        ),
        body: BlocBuilder<PaginationScreenBloc, PaginationScreenState>(
            builder: ((context, state) {
          if (state is PaginationScreenLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PaginationScreenErrorState) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                textAlign: TextAlign.center,
              ),
            );
          }
          if (state is PaginationScreenSuccessState) {
            debugPrint('name: ${state.beerList.length}');
            return ListView.builder(
                controller: scrollController,
                itemCount: state.beerList.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.beerList.length) {
                    return ListTile(
                      title: Text(
                        '${state.beerList[index].name}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        '${state.beerList[index].tagline}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                    // return null;
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state.hasMore
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Center(child: Text('No More Data')),
                    );
                  }
                });
          }

          return const SizedBox();
        })),
      ),
    );
  }
}
