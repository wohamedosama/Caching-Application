import 'package:flutter_caching/core/constant/db_keys.dart';
import 'package:flutter_caching/core/repos/interface_repos.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';

class HomeDataBaseServices implements InterfaceRepos<ProductsModel> {
  static const String _key = DbKeys.products;
  Box<ProductsModel>? _productsBox;

  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(ProductsModelAdapter());
      Hive.registerAdapter(ProductAdapter());
      _productsBox = await Hive.openBox<ProductsModel>(_key);
      Logger().d('DataBase initialized');
    } catch (error) {
      Logger().e('Error initializing DataBase: $error');
    }
  }

  Box<ProductsModel>? get _box {
    if (_productsBox != null && _productsBox!.isOpen) {
      return _productsBox;
    }
    // If box is already open in Hive, get it
    if (Hive.isBoxOpen(_key)) {
      _productsBox = Hive.box<ProductsModel>(_key);
      return _productsBox;
    }
    return null;
  }

  @override
  Future<ProductsModel?> getAll() async {
    try {
      final box = _box;
      if (box != null && box.isNotEmpty) {
        return box.get(_key);
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
      final box = _box;
      if (box != null) {
        await box.put(_key, model);
        Logger().d('Data added successfully');
      }
    } catch (error) {
      Logger().e('Error adding data: $error');
    }
  }

  @override
  Future<bool> isDataAvailable() async {
    try {
      final box = _box;
      return box?.isEmpty ?? true;
    } catch (error) {
      Logger().e('Error checking if data is available: $error');
    }
    return true;
  }
}
