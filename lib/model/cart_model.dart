class Cart {
  late final int? id;
  final String? itemId;
  final String? itemName;
  final double? unitPrice;
  double? itemPrice;
  int? quantity;
  final String? outletID;
  final String? outletName;

  Cart({
    this.id,
    this.itemId,
    this.itemName,
    this.unitPrice,
    this.itemPrice,
    this.quantity,
    this.outletID,
    this.outletName,
  });

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        itemId = data['itemId'],
        itemName = data['itemName'],
        unitPrice = data['unitPrice'],
        itemPrice = data['itemPrice'],
        quantity = data['quantity'],
        outletID = data['outletID'],
        outletName = data['outletName'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemId': itemId,
      'itemName': itemName,
      'unitPrice': unitPrice,
      'itemPrice': itemPrice,
      'quantity': quantity,
      'outletID': outletID,
      'outletName': outletName,
    };
  }
}
