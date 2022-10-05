import 'package:glados/glados.dart'
    as g; //XXX: since some methods and props are also define in the flutter test lib, we add a preffix
import 'package:warehouse_prop_testing/warehouse.dart';

/* 
 * Example of generator for a custom model. 
 * 
 * Generator are parametric, so the target type T is passed as param
 * 
 * combineN() methods take N parameters
 */
extension AnyOrderStatus on g.Any {
  g.Generator<OrderStatus> get orderStatus =>
      combine3(g.any.lowercaseLetters, g.any.lowercaseLetters, g.any.int, (String status, String name, int quantity) {
        return OrderStatus(status, name, quantity);
      });
}

/*
 * Shrinking in this context means generating combinations of a given input.
 * 
 * In our example, since we have "shoes", we could return permutations such as ["Shoes", "SHOES", "Shoe", "shoe"]
 * and see how the program handles them 
 */
Iterable<g.Shrinkable<String>> shrinkValues() {
  return [];
}

/*
 * Entry point for testing
 */
void main() {
  /*
   * Helper methods used to "force" certain input for our tests  
   */
  g.Shrinkable<String> customShoes(g.Random r, int i) {
    return g.Shrinkable("shoes", shrinkValues);
  }

  g.Shrinkable<String> customHats(g.Random r, int i) {
    return g.Shrinkable("hats", shrinkValues);
  }

  g.Shrinkable<String> customHatsOrShoes(g.Random r, int i) {
    return g.Shrinkable(r.nextBool() ? "hats" : "shoes", shrinkValues);
  }

  g.Any.setDefault<String>(g.any.lowercaseLetters);

  /*
   * Property-based tests are Glados().test() instead of simple test()
   * 
   * The GladosN states the number of inputs for the current test 
   */
  g.Glados2<String, int>().test('When ordering random items and quantities then warehouse is updated',
      (String itemName, int quantity) {
    final actual = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final initial = actual.stockCount(itemName);

    final OrderStatus order = actual.order(itemName, quantity);

    if (order.status == "ok") {
      assert(actual.stockCount(itemName) + quantity == initial);
    }
  });

  /*
   * Instead of using generics like <String, int> we can also use specific values. In this case:
   * - the customShoes generator will simply return "shoes" with no permutations
   * - the g.any.int will return random integers 
   */
  g.Glados2(customShoes, g.any.int).test('When ordering only shoes in random quantities then warehouse is updated',
      (itemName, quantity) {
    final actual = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final initial = actual.stockCount(itemName);

    final OrderStatus order = actual.order(itemName, quantity);

    if (order.status == "ok") {
      assert(actual.stockCount(itemName) + quantity == initial);
    }
  });

  g.Glados2(customHats, g.any.int).test('When ordering only hats in random quantities then warehouse is updated',
      (itemName, quantity) {
    final actual = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final initial = actual.stockCount(itemName);

    final OrderStatus order = actual.order(itemName, quantity);

    if (order.status == "ok") {
      assert(actual.stockCount(itemName) + quantity == initial);
    }
  });

  g.Glados2(customHatsOrShoes, g.any.int)
      .test('When ordering hats or shoes in random quantities then warehouse is updated', (itemName, quantity) {
    final actual = Warehouse({"shoes": 10, "hats": 2, "umbrellas": 0});

    final initial = actual.stockCount(itemName);

    final OrderStatus order = actual.order(itemName, quantity);

    if (order.status == "ok") {
      assert(actual.stockCount(itemName) + quantity == initial);
    }
  });
}
