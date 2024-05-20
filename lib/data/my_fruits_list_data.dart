import 'package:flutter_application_bloc_demo/modal/fruit_modal.dart';

class FruitsData {
  static List<FruitModal> fruitsList = [
    FruitModal(
        id: 1,
        name: 'Apple',
        price: 20.22,
        imageUrl:
            'https://images.pexels.com/photos/1131079/pexels-photo-1131079.jpeg?auto=compress&cs=tinysrgb&w=400'),
    FruitModal(
        id: 2,
        name: 'Grapes',
        price: 15.0,
        imageUrl:
            'https://images.pexels.com/photos/60021/grapes-wine-fruit-vines-60021.jpeg?auto=compress&cs=tinysrgb&w=400'),
    FruitModal(
        id: 3,
        name: 'Mongo',
        price: 100.20,
        imageUrl:
            'https://images.pexels.com/photos/2294471/pexels-photo-2294471.jpeg?auto=compress&cs=tinysrgb&w=400')
  ];
}
