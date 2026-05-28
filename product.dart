import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// --- 1. Data Models ---

class ProductList {
  final List<Product> items;
  final int total;
  final int skip;
  final int limit;

  ProductList({
    required this.items,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    final listJson = json['products'] as List;
    final List<Product> items = listJson
        .map((item) => Product.fromJson(item))
        .toList();

    return ProductList(
      items: items,
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }
}

class ProductDimensions {
  final double width;
  final double height;
  final double depth;

  ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      depth: (json['depth'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }
}

class ProductReview {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  ProductReview({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) {
    return ProductReview(
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      date: DateTime.parse(json['date'] as String),
      reviewerName: json['reviewerName'] as String,
      reviewerEmail: json['reviewerEmail'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String sku;
  final int weight;
  final ProductDimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ProductReview> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final List<String> images;
  final String thumbnail;
  final String barcode;
  final String qrCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.images,
    required this.thumbnail,
    required this.barcode,
    required this.qrCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(), // num to handle both int/double
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      tags: [for (var tag in json['tags']) tag as String],
      brand: json['brand'] as String?,
      sku: json['sku'] as String,
      weight: (json['weight'] as num).toInt(),
      dimensions: ProductDimensions.fromJson(json['dimensions']),
      warrantyInformation: json['warrantyInformation'] as String,
      shippingInformation: json['shippingInformation'] as String,
      availabilityStatus: json['availabilityStatus'] as String,
      reviews: [
        for (var review in json['reviews']) ProductReview.fromJson(review),
      ],
      returnPolicy: json['returnPolicy'] as String,
      minimumOrderQuantity: (json['minimumOrderQuantity'] as num).toInt(),
      images: [for (var image in json['images']) image as String],
      thumbnail: json['thumbnail'] as String,
      barcode: json['meta']['barcode'] as String,
      qrCode: json['meta']['qrCode'] as String,
      createdAt: DateTime.parse(json['meta']['createdAt'] as String),
      updatedAt: DateTime.parse(json['meta']['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': [for (var review in reviews) review.toJson()],
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'images': images,
      'thumbnail': thumbnail,
      'meta': {
        'barcode': barcode,
        'qrCode': qrCode,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      },
    };
  }
}

// --- 2. API Services ---

class ProductApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  /// Fetches a list of items from the DummyJSON API.
  static Future<ProductList> fetchItems() async {
    final response = await http.get(Uri.parse('$_baseUrl/products'));

    if (response.statusCode == 200) {
      return ProductList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  /// Fetches a single item by ID from the DummyJSON API.
  static Future<Product> fetchItem(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}

// --- 3. Providers ---

class ProductListProvider extends ChangeNotifier {
  late Future<ProductList> _future;

  ProductListProvider() {
    _future = ProductApiService.fetchItems();
  }

  Future<ProductList> get future => _future;

  void refresh() {
    _future = ProductApiService.fetchItems();
    notifyListeners();
  }
}

class ProductProvider extends ChangeNotifier {
  final int _id;
  late Future<Product> _future;

  ProductProvider(this._id) {
    _future = ProductApiService.fetchItem(_id);
  }

  Future<Product> get future => _future;

  void refresh() {
    _future = ProductApiService.fetchItem(_id);
    notifyListeners();
  }
}

class ImageLoadingHandler {
  Widget loadingIndicator(ImageChunkEvent loadingProgress) => Container(
    width: 100,
    height: 100,
    color: Colors.grey[200],
    child: Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
            : null,
      ),
    ),
  );

  Widget errorIndicator() => Container(
    width: 100,
    height: 100,
    color: Colors.grey[300],
    child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
  );
}

// --- 4. Main Application Entry Point ---

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductListProvider()),
        Provider(create: (context) => ImageLoadingHandler()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DummyJSON Products',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 6,
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          shadowColor: Colors.black,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProductListScreen(),
    );
  }
}

// --- 5. Product List Screen ---

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final watcher = context.watch<ProductListProvider>();
    final reader = context.read<ProductListProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('DummyJSON Products')),
      body: FutureBuilder<ProductList>(
        future: watcher.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return LoadingErrorScreen(
              error: snapshot.error.toString(),
              onRefresh: reader.refresh,
            );
          } else if (snapshot.hasData) {
            final products = snapshot.data!.items;
            if (products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(product: product);
              },
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}

// --- 6. Product Card Widget ---

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final reader = context.read<ImageLoadingHandler>();

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                children: [
                  Image.network(
                    product.thumbnail,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                        ? child
                        : reader.loadingIndicator(loadingProgress),
                    errorBuilder: (context, error, stackTrace) =>
                        reader.errorIndicator(),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.white10,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductScreen(id: product.id),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.brand != null)
                    Text(
                      product.brand!,
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 7. Product Screen ---

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(id),
      builder: (context, child) {
        final watcher = context.watch<ProductProvider>();
        final reader = context.read<ProductProvider>();
        final loader = context.read<ImageLoadingHandler>();

        return FutureBuilder<Product>(
          future: watcher.future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return LoadingErrorScreen(
                error: snapshot.error.toString(),
                onRefresh: reader.refresh,
              );
            } else if (snapshot.hasData) {
              final product = snapshot.data!;
              return Scaffold(
                appBar: AppBar(title: Text(product.title)),
                body: ListView(
                  children: [
                    Image.network(
                      product.images[0],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                          ? child
                          : loader.loadingIndicator(loadingProgress),
                      errorBuilder: (context, error, stackTrace) =>
                          loader.errorIndicator(),
                    ),
                    Text(product.title),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        );
      },
    );
  }
}

// --- 7. Loading Error Screen ---

class LoadingErrorScreen extends StatelessWidget {
  LoadingErrorScreen({super.key, required this.error, required this.onRefresh});

  final String error;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 10),
            Text(
              'Error: ${error}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: onRefresh, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
