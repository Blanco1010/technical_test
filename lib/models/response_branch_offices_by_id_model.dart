// To parse this JSON data, do
//
//     final responseBranchOfficesById = responseBranchOfficesByIdFromMap(jsonString);

import 'dart:convert';

class ResponseBranchOfficesById {
  ResponseBranchOfficesById({
    this.data,
    required this.message,
    required this.code,
    required this.errors,
  });

  Data? data;
  String message;
  int code;
  List<dynamic> errors;

  factory ResponseBranchOfficesById.fromJson(String str) =>
      ResponseBranchOfficesById.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseBranchOfficesById.fromMap(Map<String, dynamic> json) =>
      ResponseBranchOfficesById(
        data: Data.fromMap(json["data"]),
        message: json["message"],
        code: json["code"],
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
        "message": message,
        "code": code,
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class Data {
  Data({
    required this.id,
    required this.partnerId,
    required this.brandId,
    required this.cityId,
    required this.name,
    required this.address,
    required this.email,
    required this.phone1,
    required this.phone2,
    required this.whatsapp1,
    required this.whatsapp2,
    required this.latitude,
    required this.longitude,
    required this.deliveryRate,
    required this.supportsDrivers,
    required this.isAvailable,
    required this.baseRateId,
    required this.pickupRateId,
    required this.acceptDatafono,
    required this.acceptCreditcard,
    required this.acceptCash,
    required this.hasPickup,
    required this.maxSellAmount,
    required this.minSellAmount,
    required this.minSellFreeDelivery,
    required this.tipDriverAdomi,
    required this.tipDriverPartner,
    required this.tipDriverFriend,
    required this.isComingSoon,
    required this.isCoverUploaded,
    required this.currencyId,
    required this.eta,
    required this.maximumOrders,
    required this.cover,
    required this.joinName,
    required this.orderType,
    required this.assistanceCost,
    required this.percentageAssistanceCost,
    required this.order,
    required this.isDevelop,
    required this.isWorking,
    required this.isDemo,
    required this.branchofficeType,
    required this.firebaseDynamicLink,
    required this.salesClosingTime,
    required this.transactionCost,
    required this.billingCode,
    required this.coverageRadio,
    required this.isFeatured,
    required this.adminId,
    required this.commercialZoneId,
    required this.polygon,
    required this.isVerified,
    required this.brand,
    required this.currency,
    required this.isFavoriteBranchOffice,
    required this.hasMinSellFreeDelivery,
    required this.isOpen,
    required this.message,
    required this.estimatedDeliveryTime,
    required this.isActiveBySchedule,
    required this.deliveryCost,
    required this.distanceKm,
  });

  String id;
  String partnerId;
  String brandId;
  String cityId;
  String name;
  String address;
  String email;
  String? phone1;
  String? phone2;
  String? whatsapp1;
  String? whatsapp2;
  double latitude;
  double longitude;
  String? deliveryRate;
  String? supportsDrivers;
  bool isAvailable;
  int baseRateId;
  int pickupRateId;
  bool acceptDatafono;
  bool acceptCreditcard;
  bool acceptCash;
  bool hasPickup;
  int maxSellAmount;
  int minSellAmount;
  int minSellFreeDelivery;
  String? tipDriverAdomi;
  String? tipDriverPartner;
  String? tipDriverFriend;
  bool isComingSoon;
  bool isCoverUploaded;
  String currencyId;
  dynamic eta;
  int maximumOrders;
  String cover;
  bool joinName;
  String orderType;
  String assistanceCost;
  String percentageAssistanceCost;
  int order;
  bool isDevelop;
  bool isWorking;
  bool isDemo;
  String branchofficeType;
  String? firebaseDynamicLink;
  SalesClosingTime salesClosingTime;
  int transactionCost;
  String billingCode;
  int coverageRadio;
  bool isFeatured;
  dynamic adminId;
  String commercialZoneId;
  List<dynamic> polygon;
  bool isVerified;
  Brand brand;
  Currency currency;
  bool isFavoriteBranchOffice;
  bool hasMinSellFreeDelivery;
  bool isOpen;
  String message;
  EstimatedDeliveryTime estimatedDeliveryTime;
  bool isActiveBySchedule;
  dynamic deliveryCost;
  double distanceKm;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        partnerId: json["partner_id"],
        brandId: json["brand_id"],
        cityId: json["city_id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        phone1: json["phone1"],
        phone2: json["phone2"],
        whatsapp1: json["whatsapp1"],
        whatsapp2: json["whatsapp2"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        deliveryRate: json["delivery_rate"],
        supportsDrivers: json["supports_drivers"],
        isAvailable: json["is_available"],
        baseRateId: json["base_rate_id"],
        pickupRateId: json["pickup_rate_id"],
        acceptDatafono: json["accept_datafono"],
        acceptCreditcard: json["accept_creditcard"],
        acceptCash: json["accept_cash"],
        hasPickup: json["has_pickup"],
        maxSellAmount: json["max_sell_amount"],
        minSellAmount: json["min_sell_amount"],
        minSellFreeDelivery: json["min_sell_free_delivery"],
        tipDriverAdomi: json["tip_driver_adomi"],
        tipDriverPartner: json["tip_driver_partner"],
        tipDriverFriend: json["tip_driver_friend"],
        isComingSoon: json["is_coming_soon"],
        isCoverUploaded: json["is_cover_uploaded"],
        currencyId: json["currency_id"],
        eta: json["eta"],
        maximumOrders: json["maximum_orders"],
        cover: json["cover"],
        joinName: json["join_name"],
        orderType: json["order_type"],
        assistanceCost: json["assistance_cost"],
        percentageAssistanceCost: json["percentage_assistance_cost"],
        order: json["order"],
        isDevelop: json["is_develop"],
        isWorking: json["is_working"],
        isDemo: json["is_demo"],
        branchofficeType: json["branchoffice_type"],
        firebaseDynamicLink: json["firebase_dynamic_link"],
        salesClosingTime: SalesClosingTime.fromMap(json["sales_closing_time"]),
        transactionCost: json["transaction_cost"],
        billingCode: json["billing_code"],
        coverageRadio: json["coverage_radio"],
        isFeatured: json["is_featured"],
        adminId: json["admin_id"],
        commercialZoneId: json["commercial_zone_id"],
        polygon: List<dynamic>.from(json["polygon"].map((x) => x)),
        isVerified: json["is_verified"],
        brand: Brand.fromMap(json["brand"]),
        currency: Currency.fromMap(json["currency"]),
        isFavoriteBranchOffice: json["is_favorite_branch_office"],
        hasMinSellFreeDelivery: json["has_min_sell_free_delivery"],
        isOpen: json["is_open"],
        message: json["message"],
        estimatedDeliveryTime:
            EstimatedDeliveryTime.fromMap(json["estimated_delivery_time"]),
        isActiveBySchedule: json["is_active_by_schedule"],
        deliveryCost: json["delivery_cost"],
        distanceKm: json["distance_km"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "partner_id": partnerId,
        "brand_id": brandId,
        "city_id": cityId,
        "name": name,
        "address": address,
        "email": email,
        "phone1": phone1,
        "phone2": phone2,
        "whatsapp1": whatsapp1,
        "whatsapp2": whatsapp2,
        "latitude": latitude,
        "longitude": longitude,
        "delivery_rate": deliveryRate,
        "supports_drivers": supportsDrivers,
        "is_available": isAvailable,
        "base_rate_id": baseRateId,
        "pickup_rate_id": pickupRateId,
        "accept_datafono": acceptDatafono,
        "accept_creditcard": acceptCreditcard,
        "accept_cash": acceptCash,
        "has_pickup": hasPickup,
        "max_sell_amount": maxSellAmount,
        "min_sell_amount": minSellAmount,
        "min_sell_free_delivery": minSellFreeDelivery,
        "tip_driver_adomi": tipDriverAdomi,
        "tip_driver_partner": tipDriverPartner,
        "tip_driver_friend": tipDriverFriend,
        "is_coming_soon": isComingSoon,
        "is_cover_uploaded": isCoverUploaded,
        "currency_id": currencyId,
        "eta": eta,
        "maximum_orders": maximumOrders,
        "cover": cover,
        "join_name": joinName,
        "order_type": orderType,
        "assistance_cost": assistanceCost,
        "percentage_assistance_cost": percentageAssistanceCost,
        "order": order,
        "is_develop": isDevelop,
        "is_working": isWorking,
        "is_demo": isDemo,
        "branchoffice_type": branchofficeType,
        "firebase_dynamic_link": firebaseDynamicLink,
        "sales_closing_time": salesClosingTime.toMap(),
        "transaction_cost": transactionCost,
        "billing_code": billingCode,
        "coverage_radio": coverageRadio,
        "is_featured": isFeatured,
        "admin_id": adminId,
        "commercial_zone_id": commercialZoneId,
        "polygon": List<dynamic>.from(polygon.map((x) => x)),
        "is_verified": isVerified,
        "brand": brand.toMap(),
        "currency": currency.toMap(),
        "is_favorite_branch_office": isFavoriteBranchOffice,
        "has_min_sell_free_delivery": hasMinSellFreeDelivery,
        "is_open": isOpen,
        "message": message,
        "estimated_delivery_time": estimatedDeliveryTime.toMap(),
        "is_active_by_schedule": isActiveBySchedule,
        "delivery_cost": deliveryCost,
        "distance_km": distanceKm,
      };
}

class Brand {
  Brand({
    required this.logo,
    required this.id,
    required this.name,
    required this.description,
    required this.isAvailable,
  });

  String logo;
  String id;
  String name;
  String description;
  bool isAvailable;

  factory Brand.fromJson(String str) => Brand.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        logo: json["logo"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isAvailable: json["is_available"],
      );

  Map<String, dynamic> toMap() => {
        "logo": logo,
        "id": id,
        "name": name,
        "description": description,
        "is_available": isAvailable,
      };
}

class Currency {
  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  String id;
  String name;
  String code;
  String symbol;

  factory Currency.fromJson(String str) => Currency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
        "symbol": symbol,
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

class SalesClosingTime {
  SalesClosingTime({
    required this.hours,
    required this.minutes,
  });

  int hours;
  int minutes;

  factory SalesClosingTime.fromJson(String str) =>
      SalesClosingTime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SalesClosingTime.fromMap(Map<String, dynamic> json) =>
      SalesClosingTime(
        hours: json["hours"],
        minutes: json["minutes"],
      );

  Map<String, dynamic> toMap() => {
        "hours": hours,
        "minutes": minutes,
      };
}
