import 'dart:convert';

class ResponseBranchOffices {
  ResponseBranchOffices({
    required this.data,
    required this.message,
    required this.code,
    required this.errors,
  });

  List<Datum> data;
  String message;
  int code;
  List<dynamic> errors;

  factory ResponseBranchOffices.fromJson(String str) =>
      ResponseBranchOffices.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseBranchOffices.fromMap(Map<String, dynamic> json) =>
      ResponseBranchOffices(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        message: json["message"],
        code: json["code"],
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "message": message,
        "code": code,
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.address,
    required this.deliveryRate,
    required this.isAvailable,
    required this.acceptDatafono,
    required this.acceptCreditcard,
    required this.acceptCash,
    required this.hasPickup,
    required this.isComingSoon,
    required this.joinName,
    required this.latitude,
    required this.longitude,
    required this.isWorking,
    required this.isDemo,
    required this.branchofficeType,
    required this.firebaseDynamicLink,
    required this.isDevelop,
    required this.coverageRadio,
    required this.isFeatured,
    required this.brand,
    required this.isFavoriteBranchOffice,
    required this.isOpen,
    required this.message,
    required this.estimatedDeliveryTime,
    required this.distanceKm,
  });

  String id;
  String name;
  String address;
  String deliveryRate;
  bool isAvailable;
  bool acceptDatafono;
  bool acceptCreditcard;
  bool acceptCash;
  bool hasPickup;
  bool isComingSoon;
  bool joinName;
  double latitude;
  double longitude;
  bool isWorking;
  bool isDemo;
  String branchofficeType;
  String firebaseDynamicLink;
  bool isDevelop;
  int coverageRadio;
  bool isFeatured;
  Brand brand;
  bool isFavoriteBranchOffice;
  bool isOpen;
  String message;
  EstimatedDeliveryTime estimatedDeliveryTime;
  double distanceKm;

  factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        deliveryRate: json["delivery_rate"],
        isAvailable: json["is_available"],
        acceptDatafono: json["accept_datafono"],
        acceptCreditcard: json["accept_creditcard"],
        acceptCash: json["accept_cash"],
        hasPickup: json["has_pickup"],
        isComingSoon: json["is_coming_soon"],
        joinName: json["join_name"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        isWorking: json["is_working"],
        isDemo: json["is_demo"],
        branchofficeType: json["branchoffice_type"],
        firebaseDynamicLink: json["firebase_dynamic_link"] ?? '',
        isDevelop: json["is_develop"],
        coverageRadio: json["coverage_radio"],
        isFeatured: json["is_featured"],
        brand: Brand.fromMap(json["brand"]),
        isFavoriteBranchOffice: json["is_favorite_branch_office"],
        isOpen: json["is_open"],
        message: json["message"],
        estimatedDeliveryTime:
            EstimatedDeliveryTime.fromMap(json["estimated_delivery_time"]),
        distanceKm: json["distance_km"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "delivery_rate": deliveryRate,
        "is_available": isAvailable,
        "accept_datafono": acceptDatafono,
        "accept_creditcard": acceptCreditcard,
        "accept_cash": acceptCash,
        "has_pickup": hasPickup,
        "is_coming_soon": isComingSoon,
        "join_name": joinName,
        "latitude": latitude,
        "longitude": longitude,
        "is_working": isWorking,
        "is_demo": isDemo,
        "branchoffice_type": branchofficeType,
        "firebase_dynamic_link": firebaseDynamicLink,
        "is_develop": isDevelop,
        "coverage_radio": coverageRadio,
        "is_featured": isFeatured,
        "brand": brand.toMap(),
        "is_favorite_branch_office": isFavoriteBranchOffice,
        "is_open": isOpen,
        "message": message,
        "estimated_delivery_time": estimatedDeliveryTime.toMap(),
        "distance_km": distanceKm,
      };
}

class Brand {
  Brand({
    required this.logo,
    required this.id,
    required this.name,
    required this.isAvailable,
    required this.description,
  });

  String logo;
  String id;
  String name;
  bool isAvailable;
  String description;

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        logo: json["logo"],
        id: json["id"],
        name: json["name"],
        isAvailable: json["is_available"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "logo": logo,
        "id": id,
        "name": name,
        "is_available": isAvailable,
        "description": description,
      };
}

class EstimatedDeliveryTime {
  EstimatedDeliveryTime({
    required this.from,
    required this.to,
  });

  From from;
  From to;

  factory EstimatedDeliveryTime.fromJson(String str) =>
      EstimatedDeliveryTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EstimatedDeliveryTime.fromMap(Map<String, dynamic> json) =>
      EstimatedDeliveryTime(
        from: From.fromMap(json["from"]),
        to: From.fromMap(json["to"]),
      );

  Map<String, dynamic> toMap() => {
        "from": from.toMap(),
        "to": to.toMap(),
      };
}

class From {
  From({
    required this.days,
    required this.hours,
    required this.minutes,
  });

  String days;
  String hours;
  String minutes;

  factory From.fromJson(String str) => From.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory From.fromMap(Map<String, dynamic> json) => From(
        days: json["days"],
        hours: json["hours"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toMap() => {
        "days": days,
        "hours": hours,
        "minutes": minutes,
      };
}
