import 'package:bloc/bloc.dart';
import 'package:flutter_caching/core/dependency_injection/di.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:flutter_caching/features/home/data/repo/get_product_repo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_cubit.freezed.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(GetProductRepo getProductRepo) : super(ProductState.initial());

  Future<void> getAllProducts() async {
    emit(ProductState.loading());
    final result = await getIt<GetProductRepo>().getProducts();
    result.when(
      success: (products) {
        emit(ProductState.success(products));
      },
      failure: (message) {
        emit(ProductState.error(message));
      },
    );
    return;
  }
}
