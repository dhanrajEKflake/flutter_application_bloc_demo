import 'package:flutter_application_bloc_demo/modal/beer_response_modal.dart';

abstract class PaginationRepo {
  Future<List<BeerResponseModal>> getMyBeers(int pageNumber);
}
