
import 'package:drift/web.dart';
import 'package:shopper/src/repositories/drift/drift_models.dart';

DriftShopperDatabase openConnection() {
  return DriftShopperDatabase(WebDatabase('shopperdb'));
}