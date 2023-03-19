

// used to open a connection, see https://drift.simonbinder.eu/docs/getting-started/
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path_lib;
import 'package:shopper/src/features/groceries_list/data/repositories/drift/drift_models.dart';


DriftShopperDatabase openConnection() {
  final db = LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path_lib.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
  return DriftShopperDatabase(db);
}