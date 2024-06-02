class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final double? unitPrice;
  final double? productPrice;
  final int? quantity;
  final String? outletID;
  final String? outletName;

  Cart({
    this.id,
    this.productId,
    this.productName,
    this.unitPrice,
    this.productPrice,
    this.quantity,
    this.outletID,
    this.outletName,
  });

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        unitPrice = data['unitPrice'],
        productPrice = data['productPrice'],
        quantity = data['quantity'],
        outletID = data['outletID'],
        outletName = data['outletName'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'unitPrice': unitPrice,
      'productPrice': productPrice,
      'quantity': quantity,
      'outletID': outletID,
      'outletName': outletName,
    };
  }
}
