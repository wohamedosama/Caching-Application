import 'package:flutter_caching/core/constant/db_keys.dart';
import 'package:flutter_caching/core/repos/interface_repos.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';

class HomeDataBaseServices implements InterfaceRepos<ProductsModel> {
  static const String _key = DbKeys.products;
  late final Box<ProductsModel> _productsBox;

  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(ProductsModelAdapter());
      Hive.registerAdapter(ProductAdapter());
      Hive.openBox(_key);
      Logger().d('DataBase initialized');
    } catch (error) {
      Logger().e('Error initializing DataBase: $error');
    }
  }

  @override
  Future<ProductsModel?> getAll() async {
    try {
      if (_productsBox.isOpen && _productsBox.isNotEmpty) {
        return _productsBox.get(_key);
      } else {
        return null;
      }
    } catch (error) {
      Logger().e('Error getting all data: $error');
    }
    return null;
  }

  @override
  Future<void> addData(ProductsModel model) async {
    try {
      await _productsBox.put(_key, model);
      Logger().d('Data added successfully');
    } catch (error) {
      Logger().e('Error adding data: $error');
    }
  }

  @override
  Future<bool> isDataAvailable() async {
    try {
      return _productsBox.isEmpty;
    } catch (error) {
      Logger().e('Error checking if data is available: $error');
    }
    return true;
  }
}
