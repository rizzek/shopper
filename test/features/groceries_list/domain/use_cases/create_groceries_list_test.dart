
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopper/src/features/groceries_list/domain/entities/groceries_list.dart';
import 'package:shopper/src/features/groceries_list/domain/repositories/groceries_list_repository.dart';
import 'package:shopper/src/features/groceries_list/domain/use_cases/create_groceries_list.dart';

@GenerateNiceMocks([MockSpec<GroceriesListRepository>()])
import 'create_groceries_list_test.mocks.dart';

void main() {
  const testTitle = "New List Title";
  MockGroceriesListRepository repository = MockGroceriesListRepository();
  CreateGroceriesList usecase;
  GroceriesList groceriesList = GroceriesList(title: testTitle, id: 1);
  
  setUp(() {
    repository = MockGroceriesListRepository();
    usecase = CreateGroceriesList(repository);
  });
  
  test("Should create list", () async {
    when(repository.createShoppingList(title: any)).thenAnswer((realInvocation) async {
      return GroceriesList(title: testTitle, id: 1);
    });
  }
  );
}