class ProductItem {
  final int ManufacturerID;
  final String productName;
  final String productSN;
  final String productBrand;
  final int productPrice;
  String productStatus; // mutable as status may change

  ProductItem({
    required this.ManufacturerID,
    required this.productName,
    required this.productSN,
    required this.productBrand,
    required this.productPrice,
    required this.productStatus,
  });
}
