import 'package:flutter/material.dart';
import 'package:flutter_application_bloc_demo/modal/fruit_modal.dart';

class FruitTileWidget extends StatelessWidget {
  const FruitTileWidget(
      {super.key,
      required this.myFruit,
      required this.onTapCartIcon,
      required this.onTapFavIcon});
  final FruitModal myFruit;
  final VoidCallback onTapCartIcon;
  final VoidCallback onTapFavIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                image: DecorationImage(
                    image: NetworkImage(
                      myFruit.imageUrl,
                    ),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            myFruit.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee,
                    size: 16,
                  ),
                  Text(
                    myFruit.price.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: onTapFavIcon,
                      icon: const Icon(
                        Icons.favorite_border,
                      )),
                  IconButton(
                      onPressed: onTapCartIcon,
                      icon: const Icon(
                        Icons.shopping_cart,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
