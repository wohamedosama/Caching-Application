import 'package:flutter_caching/core/local/home_data_base_services.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:logger/logger.dart';

class HomeDateBaseProvider {
  final HomeDataBaseServices homeDataBaseServices;
  HomeDateBaseProvider(this.homeDataBaseServices);
  Future<ProductsModel?> getAll() async {
    try {
      return await homeDataBaseServices.getAll();
    } catch (error) {
      Logger().e('Error getting Products: $error');
    }
    return null;
  }

  Future<void> addData(ProductsModel model) async {
    try {
      await homeDataBaseServices.addData(model);
      Logger().d('Products added successfully');
    } catch (error) {
      Logger().e('Error adding Products: $error');
    }
  }

  Future<bool> isDataAvailable() async {
    try {
      return await homeDataBaseServices.isDataAvailable();
    } catch (error) {
      Logger().e('Error checking if data is available: $error');
    }
    return false;
  }
}
