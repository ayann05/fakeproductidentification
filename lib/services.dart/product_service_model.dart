import 'package:fpidapp/model/productModel.dart';
import 'package:fpidapp/model/sellerModel.dart';

class ProductContract {
  int sellerCount = 0;
  int productCount = 0;

  final Map<int, Seller> sellers = {};
  final Map<int, ProductItem> productItems = {};
  final Map<String, int> productMap = {};

  // Mappings from Solidity are represented as Maps in Dart
  final Map<String, List<String>> productsWithSeller = {};
  final Map<String, String> productsForSale = {};
  final Map<String, String> productsSold = {};
  final Map<String, List<String>> productsWithConsumer = {};
  final Map<String, List<String>> sellersWithManufacturer = {};

  void addSeller(
      int manufacturerId,
      String sellerName,
      String sellerBrand,
      String sellerCode,
      int sellerNum,
      String sellerManager,
      String sellerAddress) {
    var seller = Seller(
      sellerId: sellerCount,
      sellerName: sellerName,
      sellerBrand: sellerBrand,
      sellerCode: sellerCode,
      sellerNum: sellerNum,
      sellerManager: sellerManager,
      sellerAddress: sellerAddress,
    );
    sellers[sellerCount] = seller;
    sellerCount++;

    sellersWithManufacturer
        .putIfAbsent(manufacturerId.toString(), () => [])
        .add(sellerCode);
  }

  void addProduct(int manufacturerID, String productName, String productSN,
      String productBrand, int productPrice) {
    var product = ProductItem(
      ManufacturerID: manufacturerID,
      productSN: productSN,
      productName: productName,
      productBrand: productBrand,
      productPrice: productPrice,
      productStatus: 'Available',
    );
    productItems[productCount] = product;
    productMap[productSN] = productCount;
    productCount++;
  }

  // Additional methods would be needed to fully simulate all contract functionality.
}





// import 'package:fpidapp/model/productModel.dart';
// import 'package:fpidapp/model/sellerModel.dart';

// class ProductContract {
//   int sellerCount = 0;
//   int productCount = 0;

//   final Map<int, Seller> sellers = {};
//   final Map<int, ProductItem> productItems = {};
//   final Map<String, int> productMap = {};

//   // Mappings from Solidity are represented as Maps in Dart
//   final Map<String, List<String>> productsWithSeller = {};
//   final Map<String, String> productsForSale = {};
//   final Map<String, String> productsSold = {};
//   final Map<String, List<String>> productsWithConsumer = {};
//   final Map<String, List<String>> sellersWithManufacturer = {};

//   void addSeller(
//       String manufacturerId,
//       String sellerName,
//       String sellerBrand,
//       String sellerCode,
//       int sellerNum,
//       String sellerManager,
//       String sellerAddress) {
//     var seller = Seller(
//       sellerId: sellerCount,
//       sellerName: sellerName,
//       sellerBrand: sellerBrand,
//       sellerCode: sellerCode,
//       sellerNum: sellerNum,
//       sellerManager: sellerManager,
//       sellerAddress: sellerAddress,
//     );
//     sellers[sellerCount] = seller;
//     sellerCount++;

//     sellersWithManufacturer
//         .putIfAbsent(manufacturerId, () => [])
//         .add(sellerCode);
//   }

//   void addProduct(String manufacturerID, String productName, String productSN,
//       String productBrand, int productPrice) {
//     var product = ProductItem(
//       productId: productCount,
//       productSN: productSN,
//       productName: productName,
//       productBrand: productBrand,
//       productPrice: productPrice,
//       productStatus: 'Available',
//     );
//     productItems[productCount] = product;
//     productMap[productSN] = productCount;
//     productCount++;
//   }

//   // Additional methods would be needed to fully simulate all contract functionality.
// }
