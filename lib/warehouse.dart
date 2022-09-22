/// Storage model that contains a map of {String, int}
class Warehouse {
  Map<String, int> stock;

  Warehouse(this.stock) : super();

  void init(Map<String, int> stock) {
    this.stock = stock;
  }

  bool inStock(String itemName) => stock.containsKey(itemName) && stock[itemName]! > 0;
  bool inEnoughStock(String itemName, int quantity) => stock.containsKey(itemName) && stock[itemName]! >= quantity;

  void takeFromStock(String itemName, int quantity) {
    if (quantity <= stock[itemName]!) {
      stock[itemName] = stock[itemName]! - quantity;
    } else {
      throw OutOfStockException("No $itemName items left");
    }
  }

  int stockCount(String itemName) => stock[itemName] ?? 0;

  OrderStatus order(String itemName, int quantity) {
    //XXX: comment/uncomment and run tests
    //if (inStock(itemName)) {
    if (inEnoughStock(itemName, quantity)) {
      takeFromStock(itemName, quantity);

      return OrderStatus("ok", itemName, quantity);
    } else {
      return OrderStatus("nok", itemName, quantity);
    }
  }
}

/// Custom exception model
class OutOfStockException implements Exception {
  final String msg;

  const OutOfStockException(this.msg) : super();
}

/// Model wrapping an order status
class OrderStatus {
  final String status;
  final String itemName;
  final int quantity;

  OrderStatus(this.status, this.itemName, this.quantity) : super();
}
