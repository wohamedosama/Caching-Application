import 'package:flutter_caching/features/home/data/model/hive_helper/fields/product_fields.dart';
import 'package:flutter_caching/features/home/data/model/hive_helper/fields/products_model_fields.dart';
import 'package:flutter_caching/features/home/data/model/hive_helper/hive_types.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: HiveTypes.product)
class Product extends HiveObject {
  @HiveField(ProductFields.id)
  final int id;
  @HiveField(ProductFields.name)
  final String name;
  @HiveField(ProductFields.description)
  final String description;
  @HiveField(ProductFields.price)
  final double price;
  @HiveField(ProductFields.category)
  final String category;
  @HiveField(ProductFields.photoUrl)
  final String photoUrl;
  @HiveField(ProductFields.createdAt)
  final DateTime createdAt;
  @HiveField(ProductFields.updatedAt)
  final DateTime updatedAt;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,

      photoUrl: json['photo_url'] as String? ?? json['photoUrl'] as String,
      createdAt: DateTime.parse(
        json['created_at'] as String? ?? json['createdAt'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String? ?? json['updatedAt'] as String,
      ),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

@HiveType(typeId: HiveTypes.productsModel)
class ProductsModel extends HiveObject {
  @HiveField(ProductsModelFields.success)
  final bool success;
  @HiveField(ProductsModelFields.totalProducts)
  final int totalProducts;
  @HiveField(ProductsModelFields.message)
  final String message;
  @HiveField(ProductsModelFields.offset)
  final int offset;
  @HiveField(ProductsModelFields.limit)
  final int limit;
  @HiveField(ProductsModelFields.products)
  final List<Product> products;

  ProductsModel({
    required this.success,
    required this.totalProducts,
    required this.message,
    required this.offset,
    required this.limit,
    required this.products,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      success: json['success'] as bool,
      totalProducts: json['total_products'] as int,
      message: json['message'] as String,
      offset: json['offset'] as int,
      limit: json['limit'] as int,
      products: (json['products'] as List<dynamic>)
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'total_products': totalProducts,
      'message': message,
      'offset': offset,
      'limit': limit,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
