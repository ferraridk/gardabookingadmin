import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? id;
  final String name;
  final String category;
  final String city;
  final String imageUrl;
  final bool isApartment;
  final bool isCamping;
  final bool isSummerhouse;
  final bool isPopular;
  final bool isRecommended;
  double price;

  Product({
    this.id,
    required this.name,
    required this.category,
    required this.city,
    required this.imageUrl,
    required this.isApartment,
    required this.isCamping,
    required this.isSummerhouse,
    required this.isPopular,
    required this.isRecommended,
    required this.price,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      category,
      city,
      imageUrl,
      isApartment,
      isCamping,
      isSummerhouse,
      isPopular,
      isRecommended,
      price,
    ];
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? city,
    String? imageUrl,
    bool? isApartment,
    bool? isCamping,
    bool? isSummerhouse,
    bool? isPopular,
    bool? isRecommended,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      city: city ?? this.city,
      imageUrl: imageUrl ?? this.imageUrl,
      isApartment: isApartment ?? this.isApartment,
      isCamping: isCamping ?? this.isCamping,
      isSummerhouse: isSummerhouse ?? this.isSummerhouse,
      isPopular: isPopular ?? this.isPopular,
      isRecommended: isRecommended ?? this.isRecommended,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'city': city,
      'imageUrl': imageUrl,
      'isApartment': isApartment,
      'isCamping': isCamping,
      'isSummerhouse': isSummerhouse,
      'isPopular': isPopular,
      'isRecommended': isRecommended,
      'price': price,
    };
  }

  factory Product.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;

    return Product(
      id: snap.id,
      name: data?['name'] ?? '',
      category: data?['category'] ?? '',
      city: data?['city'] ?? '',
      imageUrl: data?['imageUrl'] ?? '',
      isApartment: data?['isApartment'] ?? false,
      isCamping: data?['isCamping'] ?? false,
      isSummerhouse: data?['isSummerhouse'] ?? false,
      isPopular: data?['isPopular'] ?? false,
      isRecommended: data?['isRecommended'] ?? false,
      price: (data?['price'] ?? 0).toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
