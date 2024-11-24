class Complaint {
  final int complaintId;
  final String complaintNo;
  final String complaintFrom;
  final int complaintTypeId;
  final String complaintDescription;
  final int statusId;
  final int chefId;
  final int userId;
  final String? status;
  final String restaurantName;
  final String? customerName;
  final String complaintType;
  final String createdDateString;

  Complaint({
    required this.complaintId,
    required this.complaintNo,
    required this.complaintFrom,
    required this.complaintTypeId,
    required this.complaintDescription,
    required this.statusId,
    required this.chefId,
    required this.userId,
    required this.status,
    required this.restaurantName,
    required this.customerName,
    required this.complaintType,
    required this.createdDateString,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      complaintId: json['complaintId'],
      complaintNo: json['complaintNo'],
      complaintFrom: json['complaintFrom'],
      complaintTypeId: json['complaintTypeId'],
      complaintDescription: json['complaintDescription'],
      statusId: json['statusId'],
      chefId: json['chefId'],
      userId: json['userId'],
      status: json['status'],
      restaurantName: json['restaurantName'],
      customerName: json['customerName'],
      complaintType: json['complaintType'],
      createdDateString: json['createdDateString'],
    );
  }

  Complaint copyWith({
    int? complaintId,
    String? complaintNo,
    String? complaintFrom,
    int? complaintTypeId,
    String? complaintDescription,
    int? statusId,
    int? chefId,
    int? userId,
    String? status,
    String? restaurantName,
    String? customerName,
    String? complaintType,
    String? createdDateString,
  }) {
    return Complaint(
      complaintId: complaintId ?? this.complaintId,
      complaintNo: complaintNo ?? this.complaintNo,
      complaintFrom: complaintFrom ?? this.complaintFrom,
      complaintTypeId: complaintTypeId ?? this.complaintTypeId,
      complaintDescription: complaintDescription ?? this.complaintDescription,
      statusId: statusId ?? this.statusId,
      chefId: chefId ?? this.chefId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      restaurantName: restaurantName ?? this.restaurantName,
      customerName: customerName ?? this.customerName,
      complaintType: complaintType ?? this.complaintType,
      createdDateString: createdDateString ?? this.createdDateString,
    );
  }
}
