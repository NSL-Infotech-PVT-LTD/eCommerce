// // To parse this JSON data, do
// //
// //     final preFiestasBookingListModel = preFiestasBookingListModelFromJson(jsonString);

// import 'dart:convert';

// PreFiestasBookingListModel preFiestasBookingListModelFromJson(String str) =>
//     PreFiestasBookingListModel.fromJson(json.decode(str));

// String preFiestasBookingListModelToJson(PreFiestasBookingListModel data) =>
//     json.encode(data.toJson());

// class PreFiestasBookingListModel {
//   PreFiestasBookingListModel({
//     this.status,
//     this.code,
//     this.data,
//   });

//   bool? status;
//   int? code;
//   Data? data;

//   factory PreFiestasBookingListModel.fromJson(Map<String, dynamic> json) =>
//       PreFiestasBookingListModel(
//         status: json["status"],
//         code: json["code"],
//         data: Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "code": code,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   Data({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });

//   int? currentPage;
//   List<Datum>? data;
//   String? firstPageUrl;
//   int? from;
//   int? lastPage;
//   String? lastPageUrl;
//   dynamic nextPageUrl;
//   String? path;
//   String? perPage;
//   dynamic prevPageUrl;
//   int? to;
//   int? total;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         currentPage: json["current_page"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         firstPageUrl: json["first_page_url"],
//         from: json["from"],
//         lastPage: json["last_page"],
//         lastPageUrl: json["last_page_url"],
//         nextPageUrl: json["next_page_url"],
//         path: json["path"],
//         perPage: json["per_page"],
//         prevPageUrl: json["prev_page_url"],
//         to: json["to"],
//         total: json["total"],
//       );

//   Map<String, dynamic> toJson() => {
//         "current_page": currentPage,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//         "first_page_url": firstPageUrl,
//         "from": from,
//         "last_page": lastPage,
//         "last_page_url": lastPageUrl,
//         "next_page_url": nextPageUrl,
//         "path": path,
//         "per_page": perPage,
//         "prev_page_url": prevPageUrl,
//         "to": to,
//         "total": total,
//       };
// }

// class Datum {
//   Datum({
//     this.id,
//     this.orderBy,
//     this.price,
//     this.transferCharge,
//     this.totalPrice,
//     this.address,
//     this.orderStatus,
//     this.paymentMode,
//     this.categoryDetail,
//     this.grandTotal,
//     this.orderItem,
//   });

//   int? id;
//   int? orderBy;
//   String? price;
//   String? transferCharge;
//   int? totalPrice;
//   Address? address;
//   OrderStatus? orderStatus;
//   PaymentMode? paymentMode;
//   CategoryDetail? categoryDetail;
//   double? grandTotal;
//   List<OrderItem>? orderItem;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         orderBy: json["order_by"],
//         price: json["price"],
//         transferCharge: json["transfer_charge"],
//         totalPrice: json["total_price"],
//         address: Address.fromJson(json["address"]),
//         orderStatus: orderStatusValues.map![json["order_status"]],
//         paymentMode: paymentModeValues.map![json["payment_mode"]],
//         categoryDetail: CategoryDetail.fromJson(json["category_detail"]),
//         grandTotal: json["grand_total"].toDouble(),
//         orderItem: List<OrderItem>.from(
//             json["order_item"].map((x) => OrderItem.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_by": orderBy,
//         "price": price,
//         "transfer_charge": transferCharge,
//         "total_price": totalPrice,
//         "address": address?.toJson(),
//         "order_status": orderStatusValues.reverse[orderStatus],
//         "payment_mode": paymentModeValues.reverse[paymentMode],
//         "category_detail": categoryDetail!.toJson(),
//         "grand_total": grandTotal,
//         "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
//       };
// }

// class Address {
//   Address({
//     this.id,
//     this.userId,
//     this.name,
//     this.streetAddress,
//     this.city,
//     this.state,
//     this.zip,
//     this.country,
//     this.addressDefault,
//     this.latitude,
//     this.longitude,
//   });

//   int? id;
//   int? userId;
//   Name? name;
//   StreetAddress? streetAddress;
//   City? city;
//   State? state;
//   String? zip;
//   Country? country;
//   String? addressDefault;
//   String? latitude;
//   String? longitude;

//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//         id: json["id"],
//         userId: json["user_id"],
//         name: nameValues.map![json["name"]],
//         streetAddress: streetAddressValues.map![json["street_address"]],
//         city: cityValues.map![json["city"]],
//         state: stateValues.map![json["state"]],
//         zip: json["zip"],
//         country: countryValues.map![json["country"]],
//         addressDefault: json["default"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "name": nameValues.reverse[name],
//         "street_address": streetAddressValues.reverse[streetAddress],
//         "city": cityValues.reverse[city],
//         "state": stateValues.reverse[state],
//         "zip": zip,
//         "country": countryValues.reverse[country],
//         "default": addressDefault,
//         "latitude": latitude,
//         "longitude": longitude,
//       };
// }

// enum City { SAHIBZADA_AJIT_SINGH_NAGAR }

// final cityValues =
//     EnumValues({"Sahibzada Ajit Singh Nagar": City.SAHIBZADA_AJIT_SINGH_NAGAR});

// enum Country { INDIA }

// final countryValues = EnumValues({"India": Country.INDIA});

// enum Name { OFFICE, WORK }

// final nameValues = EnumValues({"office": Name.OFFICE, "work": Name.WORK});

// enum State { PUNJAB }

// final stateValues = EnumValues({"Punjab": State.PUNJAB});

// enum StreetAddress { THE_8_A, UNNAMED_ROAD }

// final streetAddressValues = EnumValues(
//     {"8A": StreetAddress.THE_8_A, "Unnamed Road": StreetAddress.UNNAMED_ROAD});

// class CategoryDetail {
//   CategoryDetail({
//     this.id,
//     this.name,
//     this.parentId,
//     this.image,
//     this.description,
//     this.isInMyCart,
//     this.isInMyCartQuantity,
//     this.isFavourite,
//     this.quantityInCl,
//     this.quantityInCart,
//     this.quantity,
//     this.categories,
//     this.price,
//   });

//   int? id;
//   String? name;
//   int? parentId;
//   String? image;
//   String? description;
//   bool? isInMyCart;
//   int? isInMyCartQuantity;
//   bool? isFavourite;
//   int? quantityInCl;
//   int? quantityInCart;
//   int? quantity;
//   Categories? categories;
//   String? price;

//   factory CategoryDetail.fromJson(Map<String, dynamic> json) => CategoryDetail(
//         id: json["id"],
//         name: json["name"],
//         parentId: json["parent_id"] == null ? null : json["parent_id"],
//         image: json["image"],
//         description: json["description"],
//         isInMyCart: json["is_in_my_cart"],
//         isInMyCartQuantity: json["is_in_my_cart_quantity"],
//         isFavourite: json["is_favourite"],
//         quantityInCl:
//             json["quantity_in_cl"] == null ? null : json["quantity_in_cl"],
//         quantityInCart: json["quantity_in_cart"],
//         quantity: json["quantity"] == null ? null : json["quantity"],
//         categories: json["categories"] == null
//             ? null
//             : categoriesValues.map![json["categories"]],
//         price: json["price"] == null ? null : json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "parent_id": parentId == null ? null : parentId,
//         "image": image,
//         "description": description,
//         "is_in_my_cart": isInMyCart,
//         "is_in_my_cart_quantity": isInMyCartQuantity,
//         "is_favourite": isFavourite,
//         "quantity_in_cl": quantityInCl == null ? null : quantityInCl,
//         "quantity_in_cart": quantityInCart,
//         "quantity": quantity == null ? null : quantity,
//         "categories":
//             categories == null ? null : categoriesValues.reverse[categories],
//         "price": price == null ? null : price,
//       };
// }

// enum Categories { ALCOHOL, MIX, EXTRAS }

// final categoriesValues = EnumValues({
//   "alcohol": Categories.ALCOHOL,
//   "extras": Categories.EXTRAS,
//   "mix": Categories.MIX
// });

// class OrderItem {
//   OrderItem({
//     this.id,
//     this.orderId,
//     this.preFiestaId,
//     this.quantity,
//     this.price,
//     this.preFiesta,
//   });

//   int? id;
//   int? orderId;
//   int? preFiestaId;
//   int? quantity;
//   int? price;
//   CategoryDetail? preFiesta;

//   factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//         id: json["id"],
//         orderId: json["order_id"],
//         preFiestaId: json["pre_fiesta_id"],
//         quantity: json["quantity"],
//         price: json["price"],
//         preFiesta: CategoryDetail.fromJson(json["pre_fiesta"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "order_id": orderId,
//         "pre_fiesta_id": preFiestaId,
//         "quantity": quantity,
//         "price": price,
//         "pre_fiesta": preFiesta?.toJson(),
//       };
// }

// enum OrderStatus { EMPTY, PAID }

// final orderStatusValues =
//     EnumValues({"": OrderStatus.EMPTY, "paid": OrderStatus.PAID});

// enum PaymentMode { CARD }

// final paymentModeValues = EnumValues({"card": PaymentMode.CARD});

// class EnumValues<T> {
//   Map<String, T>? map;
//   Map<T, String>? reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map!.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
