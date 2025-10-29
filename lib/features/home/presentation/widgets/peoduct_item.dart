import 'package:flutter/material.dart';
import 'package:flutter_caching/core/widgets/custom_image_viewer.dart';
import 'package:flutter_caching/features/home/data/model/product_model.dart';
import 'package:intl/intl.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({super.key, required this.product, required this.index});

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          coloredContainer(context),
          const SizedBox(width: 12),
          nameAndDescription(context),
        ],
      ),
    );
  }

  Container coloredContainer(BuildContext context) {
    final List<Color> swatch = <Color>[
      Colors.blueGrey,
      Colors.brown,
      Colors.green,
      Colors.amber,
      Colors.teal,
      Colors.deepPurple,
    ];

    return Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: swatch[index % swatch.length],
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomImageViewer(imageUrl: product.photoUrl),
    );
  }

  Expanded nameAndDescription(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          createdAtAndUpdatedAt(context),
          const SizedBox(height: 10),
          categoryAndPrice(context),
        ],
      ),
    );
  }

  Row createdAtAndUpdatedAt(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Created', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 6),
            Text('Last Update', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              DateFormat('dd/MM/yyyy').format(product.createdAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 6),
            Text(
              DateFormat('dd/MM/yyyy').format(product.updatedAt),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Row categoryAndPrice(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            product.category.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Spacer(),
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
