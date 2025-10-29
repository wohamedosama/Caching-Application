import 'package:flutter_caching/core/dependency_injection/di.dart';
import 'package:flutter_caching/core/helper/internet_connection_helper.dart';
import 'package:flutter_caching/core/local/home_date_base_provider.dart';
import 'package:flutter_caching/core/networking/api_results.dart';
import 'package:flutter_caching/features/home/data/api/web_services.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:logger/logger.dart';

class GetProductRepo {
  final WebServices webServices;
  final HomeDateBaseProvider homeDateBaseProvider;

  GetProductRepo(this.webServices, this.homeDateBaseProvider);

  Future<ApiResult<ProductsModel>> getProducts() async {
    final bool isConnected = await getIt<InternetConnectionHelper>()
        .checkInternetConnection();
    final isDateBaseIsEmpty = await homeDateBaseProvider.isDataAvailable();
    if (isConnected) {
      try {
        final response = await webServices.getProducts();

        if (response.success == true && response.products.isNotEmpty) {
          Logger().d('Products fetched successfully');
          ProductsModel productsModel = ProductsModel.fromJson(
            response.toJson(),
          );
          homeDateBaseProvider.addData(productsModel);
          final cachedData = await homeDateBaseProvider.getAll();
          return ApiResult.success(cachedData!);
        } else {
          return ApiResult.failure('Unknown error occurred');
        }
      } catch (error) {
        if (!isDateBaseIsEmpty) {
          Logger().d('Laod Product From Date Base');
          final ProductsModel? localSourceResponse = await homeDateBaseProvider
              .getAll();
          return ApiResult.success(localSourceResponse!);
        } else {
          return ApiResult.failure('No products found in response');
        }
      }
    } else {
      if (!isDateBaseIsEmpty) {
        Logger().d('Laod Product From Date Base');
        final ProductsModel? localSourceResponse = await homeDateBaseProvider
            .getAll();
        return ApiResult.success(localSourceResponse!);
      } else {
        return ApiResult.failure('No internet connection and no cached data');
      }
    }
  }
}
