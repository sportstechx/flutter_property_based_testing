import 'package:flutter_test/flutter_test.dart';
import 'package:warehouse_prop_testing/warehouse.dart';

void main() {
  test('When warehouse created then default props are set', () async {
    final actual = Warehouse({});

    assert(actual.stock.isEmpty);
    assert(actual.stock.values.isEmpty);
  });

  test('When setting stock then values are set', () async {
    final actual = Warehouse({});
    assert(actual.stock.values.isEmpty);

    actual.init({"shoes": 1});
    assert(actual.stock.values.isNotEmpty);
  });

  test("When warehouse created with items then values are stored", () {
    final actual = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    assert(actual.inStock("shoes"));
    assert(actual.inStock("hats"));
    assert(!actual.inStock("umbrellas"));
  });

  test("When taking items then stock updated", () {
    final actual = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    actual.takeFromStock("shoes", 2);
    assert(actual.inStock("shoes"));

    actual.takeFromStock("hats", 2);
    assert(!actual.inStock("hats"));
  });

  test("When ordering items in stock then proper order returned", () {
    final warehouse = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final actual = warehouse.order("hats", 1);
    final expected = OrderStatus("ok", "hats", 1);

    expect(actual.status, expected.status);
    expect(actual.itemName, expected.itemName);
    expect(actual.quantity, expected.quantity);
  });

  test("When ordering items NOT in stock then proper order returned", () {
    final warehouse = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final actual = warehouse.order("umbrellas", 1);
    final expected = OrderStatus("nok", "umbrellas", 1);

    expect(actual.status, expected.status);
    expect(actual.itemName, expected.itemName);
    expect(actual.quantity, expected.quantity);
  });

  test("When ordering unknown items then proper order returned", () {
    final warehouse = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final actual = warehouse.order("bagel", 1);
    final expected = OrderStatus("nok", "bagel", 1);

    expect(actual.status, expected.status);
    expect(actual.itemName, expected.itemName);
    expect(actual.quantity, expected.quantity);
  });

  test("When taking more items than available then exception thrown", () {
    final warehouse = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final actual = warehouse.takeFromStock;

    expect(() => actual.call("shoes", 11), throwsA(isA<OutOfStockException>()));
  });

  test("When checking stock count then proper value returned", () {
    final warehouse = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    var actual = warehouse.stockCount("hats");
    expect(actual, 2);

    actual = warehouse.stockCount("umbrellas");
    expect(actual, 0);
  });
}
