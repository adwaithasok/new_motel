class HomeVillaModel {
  final int id;
  final String villaTitle;
  final String villaCity;
  final String? area;
  final int villaBasicPrice;
  final int villaDiscountPrice;
  final String villaGoogleLocation;
  final String villaImage;
  final String folder;

  HomeVillaModel({
    required this.id,
    required this.villaTitle,
    required this.villaCity,
    this.area,
    required this.villaBasicPrice,
    required this.villaDiscountPrice,
    required this.villaGoogleLocation,
    required this.villaImage,
    required this.folder,
  });

  factory HomeVillaModel.fromJson(Map<String, dynamic> json) {
    return HomeVillaModel(
      id: json['id'],
      villaTitle: json['villa_title'],
      villaCity: json['villa_city'],
      area: json['area'],
      villaBasicPrice: json['villa_basic_price'],
      villaDiscountPrice: json['villa_discount_price'],
      villaGoogleLocation: json['villa_google_location'],
      villaImage: json['villa_image'],
      folder: json['folder'],
    );
  }
}
