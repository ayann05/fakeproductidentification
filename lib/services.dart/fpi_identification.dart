import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpidapp/model/productModel.dart';
import 'package:fpidapp/model/sellerModel.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:web_socket_channel/io.dart';

class FakeProductIdentification extends ChangeNotifier {
  late Web3Client _web3Client;
  List<ProductItem> product = [];
  List<Seller> seller = [];

  final String _rpcUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';
  final String _wsUrl =
      Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545';
  bool isLoading = true;

  final String _privateKey =
      '0xfbbbfccd526bbe94faf002efed9472c969bf11bc8c2d36b8588515b585b22241';

  FakeProductIdentification() {
    init();
  }

  Future<void> init() async {
    _web3Client = Web3Client(
      _rpcUrl,
      http.Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getABI();
    await getCredentials();
  }

  late ContractAbi _abiCode;
  late EthereumAddress _contractAddress;
  Future<void> getABI() async {
    try {
      String abiFile =
          await rootBundle.loadString('build/contracts/ProductContract.json');
      var jsonABI = jsonDecode(abiFile);
      _abiCode =
          ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'NotesContract');
      _contractAddress =
          EthereumAddress.fromHex(jsonABI["networks"]["5777"]["address"]);
    } catch (e) {
      // Handle error loading ABI
      print('Error loading ABI: $e');
    }
  }

  late Credentials _creds;
  Future<void> getCredentials() async {
    try {
      _creds = await getCredentialsFromPrivateKey(_privateKey);
    } catch (e) {
      // Handle error getting credentials
      print('Error getting credentials: $e');
    }
  }

  Future<Credentials> getCredentialsFromPrivateKey(String privateKeyHex) async {
    return EthPrivateKey.fromHex(privateKeyHex);
  }

  late DeployedContract _FakeProductContract;
  late ContractFunction _addProducts;
  late ContractFunction _addSellers;
  late ContractFunction _sellerList;
  late ContractFunction _listOfProducts;
  late ContractFunction _verifyProducts;

  Future<void> getDeployedContracts() async {
    _FakeProductContract = DeployedContract(_abiCode, _contractAddress);
    _addProducts = _FakeProductContract.function('addProduct');
    _addSellers = _FakeProductContract.function('addSellers');
    _sellerList = _FakeProductContract.function('sellerList');
    _listOfProducts = _FakeProductContract.function('listOfProducts');
    _verifyProducts = _FakeProductContract.function('verifyProducts');
    await fetchProducts();
  }

  Future<void> addProducts(S) async {}
  Future<void> addSeller(
      String manufacturerId,
      String sellerName,
      String sellerBrand,
      String sellerCode,
      int sellerNum,
      String sellerManager,
      String sellerAddress) async {}

  Future<void> fetchProducts() async {}
  Future<void> fetchSeller() async {}
  Future<void> verifyProducts() async {}
}
