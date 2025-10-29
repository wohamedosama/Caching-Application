import 'package:dio/dio.dart';
import 'package:flutter_caching/core/constant/api_constant.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:retrofit/retrofit.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class WebServices {
  factory WebServices(Dio dio, {String? baseUrl}) = _WebServices;

  @GET(ApiConstant.getProducts)
  Future<ProductsModel> getProducts();
}
