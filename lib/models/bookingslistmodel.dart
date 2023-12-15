class Booking {
  final int bookingId;
  final int villaId;
  final int userId;
  final String checkInDate;
  final String checkOutDate;
  final int totalPrice;
  final String status;
  final String guestName;
  final String guestEmail;
  final String guestContactNumber;
  final String? gstNumber;
  final String? gstRegisteredCompany;
  final String? gstCompanyAddress;
  final String createdAt;
  final String updatedAt;
  final String villaTitle; // New field
  final String villaDesc; // New field
  final String villaSurroundings; // New field
  final String villaCity; // New field
  final String villaArea; // New field

  Booking({
    required this.bookingId,
    required this.villaId,
    required this.userId,
    required this.checkInDate,
    required this.checkOutDate,
    required this.totalPrice,
    required this.status,
    required this.guestName,
    required this.guestEmail,
    required this.guestContactNumber,
    this.gstNumber,
    this.gstRegisteredCompany,
    this.gstCompanyAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.villaTitle,
    required this.villaDesc,
    required this.villaSurroundings,
    required this.villaCity,
    required this.villaArea,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'],
      villaId: json['villa_id'],
      userId: json['user_id'],
      checkInDate: json['check_in_date'],
      checkOutDate: json['check_out_date'],
      totalPrice: json['total_price'],
      status: json['status'],
      guestName: json['guest_name'],
      guestEmail: json['guest_email'],
      guestContactNumber: json['guest_contact_number'],
      gstNumber: json['gst_number'],
      gstRegisteredCompany: json['gst_registered_company'],
      gstCompanyAddress: json['gst_company_address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      villaTitle: json['villa_title'],
      villaDesc: json['villa_desc'],
      villaSurroundings: json['villa_surroundings'],
      villaCity: json['villa_city'],
      villaArea: json['villa_area'],
    );
  }
}
