
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_list.dart';

abstract class GroceriesListRepository {
  Future<GroceriesList> createShoppingList({required String title});
}