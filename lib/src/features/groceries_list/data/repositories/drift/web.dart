
import 'package:drift/web.dart';
import 'package:shopper/src/features/groceries_list/data/repositories/drift/drift_models.dart';


DriftShopperDatabase openConnection() {
  return DriftShopperDatabase(WebDatabase('shopperdb'));
}