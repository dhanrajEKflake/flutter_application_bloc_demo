import 'dart:developer';

import 'package:flutter_application_bloc_demo/modal/beer_response_modal.dart';
import 'package:flutter_application_bloc_demo/services/exception/exception.dart';
import 'package:flutter_application_bloc_demo/services/repo/pagination_repos/pagination_repo.dart';
import 'package:flutter_application_bloc_demo/services/services.dart';

class PaginationRepoImpl extends PaginationRepo {
  @override
  Future<List<BeerResponseModal>> getMyBeers(pageNumber) async {
    // TODO: implement getMyBeers
    // throw UnimplementedError();
    try {
      var response = await apiService.get(
          path:
              'https://api.punkapi.com/v2/beers?page=$pageNumber&per_page=20');
      if (response.statusCode == 200) {
        List listData = response.data;
        log('mylist******** $listData');
        return listData.map((e) => BeerResponseModal.fromJson(e)).toList();
      }
      return [] as List<BeerResponseModal>;
    } catch (e) {
      throw RepoException(e.toString());
    }
  }
}
