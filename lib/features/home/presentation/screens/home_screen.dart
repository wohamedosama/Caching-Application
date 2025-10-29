import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caching/core/dependency_injection/di.dart';
import 'package:flutter_caching/core/dependency_injection/di_export.dart';
import 'package:flutter_caching/core/widgets/custom_alert.dart';
import 'package:flutter_caching/core/widgets/custom_loading_indicator.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:flutter_caching/features/home/presentation/widgets/error_message_widgets.dart';
import 'package:flutter_caching/features/home/presentation/widgets/peoduct_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Caching Data With Hive & Bloc'),
        centerTitle: true,
      ),
      body: BlocConsumer<ProductCubit, ProductState>(
        buildWhen: (previous, current) => current != previous,
        listenWhen: (previous, current) => current != previous,
        listener: (context, state) {
          state.whenOrNull(
            success: (ProductsModel model) {
              // Handle async operation without making listener async
              getIt<InternetConnectionHelper>().checkInternetConnection().then((
                isConnected,
              ) {
                final String source = isConnected
                    ? 'From Server 🌐'
                    : 'From Cache ⚡';
                if (context.mounted) {
                  CustomAlert.showAlert(context, '${model.message} $source');
                }
              });
            },
            error: (message) => CustomAlert.showAlert(context, message),
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const CustomLoadingIndicator(),
            success: (ProductsModel model) {
              final products = model.products;

              return LiquidPullToRefresh(
                showChildOpacityTransition: true,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                onRefresh: () async {
                  await BlocProvider.of<ProductCubit>(context).getAllProducts();
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: products.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductItems(product: product, index: index);
                  },
                ),
              );
            },
            error: (message) => Center(
              child: ErrorMessageWidget(
                message: message,
                onPressed: () {
                  BlocProvider.of<ProductCubit>(context).getAllProducts();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
