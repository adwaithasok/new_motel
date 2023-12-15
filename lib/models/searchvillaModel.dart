class SearchVillaModel {
  final int id;
  final String villaTitle;
  final String villaCity;
  final String area;
  final int villaBasicPrice;
  final int villaDiscountPrice;
  final String villaGoogleLocation;

  SearchVillaModel({
    required this.id,
    required this.villaTitle,
    required this.villaCity,
    required this.area,
    required this.villaBasicPrice,
    required this.villaDiscountPrice,
    required this.villaGoogleLocation,
  });

  factory SearchVillaModel.fromJson(Map<String, dynamic> json) {
    return SearchVillaModel(
      id: json['id'] ?? 0,
      villaTitle: json['villa_title'] ?? '',
      villaCity: json['villa_city'] ?? '',
      area: json['area'] ?? '',
      villaBasicPrice: json['villa_basic_price'] ?? 0,
      villaDiscountPrice: json['villa_discount_price'] ?? 0,
      villaGoogleLocation: json['villa_google_location'] ?? '',
    );
  }
}
