import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    // TODO: implement initState
    cartBloc.add(CartFetchCartItemsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cartBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: BlocConsumer<CartBloc, CartState>(
            listenWhen: ((previous, current) => current is! CartSuccessState),
            buildWhen: ((previous, current) =>
                current is CartSuccessState || current is CartLoadingState),
            builder: ((context, state) {
              debugPrint(state.runtimeType.toString());
              if (state is CartLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              if (state is CartSuccessState) {
                return state.cartList.isEmpty
                    ? const Center(
                        child: Text('No Fruits Added!'),
                      )
                    : ListView.builder(
                        itemCount: state.cartList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          state.cartList[index].imageUrl))),
                            ),
                            title: Text(
                              state.cartList[index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('Rs.${state.cartList[index].price}'),
                            trailing: IconButton(
                                onPressed: () {
                                  cartBloc.add(CartRemoveItemEvent(
                                      myFruit: state.cartList[index]));
                                },
                                icon: const Icon(Icons.remove_shopping_cart)),
                          );
                        });
              }

              if (state is CartErrorState) {
                const Center(
                  child: Text('Error'),
                );
              }

              return const SizedBox();
            }),
            listener: (context, state) {
              if (state is CartErrorState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Error.....')));
              }
            }),
        bottomNavigationBar: SafeArea(
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartSuccessState) {
              return state.cartList.isEmpty
                  ? const SizedBox()
                  : Container(
                      decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: Colors.black))),
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rs.${state.totalAmount.toString()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
