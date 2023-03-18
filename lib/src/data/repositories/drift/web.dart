
import 'package:drift/web.dart';
import 'package:shopper/src/data/repositories/drift/drift_models.dart';

DriftShopperDatabase openConnection() {
  return DriftShopperDatabase(WebDatabase('shopperdb'));
}