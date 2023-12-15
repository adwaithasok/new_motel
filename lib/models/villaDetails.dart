class VillaDetails {
  final int? id;
  final String? villaTitle;
  final String? villaDesc;
  final String? villaSurroundings;
  final String? villaServices;
  final String? villaIsFeatured;
  final String? villaFeaturedFrom;
  final String? villaFeaturedTo;
  final String? villaCity;
  final String? area;
  final int? villaBasicPrice;
  final int? villaDiscountPrice;
  final String? villaGoogleLocation;
  final String? villaAmenities;
  final String? villaComplements;
  final String? villaCheckIn;
  final String? villaCheckOut;
  final int? villaStatus;
  final String? createdAt;
  final String? updatedAt;
  final String? imageFolder; // Added field for image folder
  final List<VillaImage>? images; // Added field for images

  VillaDetails({
    this.id,
    this.villaTitle,
    this.villaDesc,
    this.villaSurroundings,
    this.villaServices,
    this.villaIsFeatured,
    this.villaFeaturedFrom,
    this.villaFeaturedTo,
    this.villaCity,
    this.area,
    this.villaBasicPrice,
    this.villaDiscountPrice,
    this.villaGoogleLocation,
    this.villaAmenities,
    this.villaComplements,
    this.villaCheckIn,
    this.villaCheckOut,
    this.villaStatus,
    this.createdAt,
    this.updatedAt,
    this.imageFolder,
    this.images,
  });

  factory VillaDetails.fromJson(Map<String, dynamic> json) {
    return VillaDetails(
      id: json['id'],
      villaTitle: json['villa_title'],
      villaDesc: json['villa_desc'],
      villaSurroundings: json['villa_surroundings'],
      villaServices: json['villa_services'],
      villaIsFeatured: json['villa_is_featured'],
      villaFeaturedFrom: json['villa_featured_from'],
      villaFeaturedTo: json['villa_featured_to'],
      villaCity: json['villa_city'],
      area: json['area'],
      villaBasicPrice: json['villa_basic_price'],
      villaDiscountPrice: json['villa_discount_price'],
      villaGoogleLocation: json['villa_google_location'],
      villaAmenities: json['villa_amenities'],
      villaComplements: json['villa_complements'],
      villaCheckIn: json['villa_check_in'],
      villaCheckOut: json['villa_check_out'],
      villaStatus: json['villa_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageFolder: json['image_folder'],
      images: (json['images'] as List<dynamic>?)
          ?.map((image) => VillaImage.fromJson(image))
          .toList(),
    );
  }
}

class VillaImage {
  final int? villaImgId;
  final int? villaId;
  final String? villaImage;
  final dynamic villaSortOrder;
  final int? villaImgStatus;
  final String? createdAt;
  final String? updatedAt;

  VillaImage({
    this.villaImgId,
    this.villaId,
    this.villaImage,
    this.villaSortOrder,
    this.villaImgStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory VillaImage.fromJson(Map<String, dynamic> json) {
    return VillaImage(
      villaImgId: json['villa_img_id'],
      villaId: json['villa_id'],
      villaImage: json['villa_image'],
      villaSortOrder: json['villa_sort_order'],
      villaImgStatus: json['villa_img_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
