// To parse this JSON data, do
//
//     final prefiestasDetailModel = prefiestasDetailModelFromJson(jsonString);

import 'dart:convert';

PrefiestasDetailModel prefiestasDetailModelFromJson(String str) =>
    PrefiestasDetailModel.fromJson(json.decode(str));

String prefiestasDetailModelToJson(PrefiestasDetailModel data) =>
    json.encode(data.toJson());

class PrefiestasDetailModel {
  PrefiestasDetailModel({
    this.status,
    this.code,
    this.data,
  });

  bool? status;
  int? code;
  Data? data;

  factory PrefiestasDetailModel.fromJson(Map<String, dynamic> json) =>
      PrefiestasDetailModel(
        status: json["status"],
        code: json["code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.parentData,
    this.childData,
  });

  ParentData? parentData;
  ChildData? childData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        parentData: ParentData.fromJson(json["parentData"]),
        childData: ChildData.fromJson(json["childData"]),
      );

  Map<String, dynamic> toJson() => {
        "parentData": parentData?.toJson(),
        "childData": childData?.toJson(),
      };
}

class ChildData {
  ChildData({
    this.alcohol,
    this.mix,
    this.extras,
  });

  List<Alcohol>? alcohol;
  List<Alcohol>? mix;
  List<Alcohol>? extras;

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        alcohol:
            List<Alcohol>.from(json["alcohol"].map((x) => Alcohol.fromJson(x))),
        mix: List<Alcohol>.from(json["mix"].map((x) => Alcohol.fromJson(x))),
        extras:
            List<Alcohol>.from(json["extras"].map((x) => Alcohol.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "alcohol": List<dynamic>.from(alcohol!.map((x) => x.toJson())),
        "mix": List<dynamic>.from(mix!.map((x) => x.toJson())),
        "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
      };
}

class Alcohol {
  Alcohol({
    this.id,
    this.name,
    this.parentId,
    this.categories,
    this.description,
    this.image,
    this.price,
    this.quantity,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
  });

  int? id;
  String? name;
  int? parentId;
  String? categories;
  String? description;
  String? image;
  String? price;
  int? quantity;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;

  factory Alcohol.fromJson(Map<String, dynamic> json) => Alcohol(
        id: json["id"],
        name: json["name"],
        parentId: json["parent_id"],
        categories: json["categories"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "parent_id": parentId,
        "categories": categories,
        "description": description,
        "image": image,
        "price": price,
        "quantity": quantity,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
      };
}

class ParentData {
  ParentData({
    this.id,
    this.name,
    this.description,
    this.categories,
    this.image,
    this.status,
    this.isInMyCart,
    this.isInMyCartQuantity,
    this.isFavourite,
  });

  int? id;
  String? name;
  String? description;
  dynamic categories;
  String? image;
  String? status;
  bool? isInMyCart;
  int? isInMyCartQuantity;
  bool? isFavourite;

  factory ParentData.fromJson(Map<String, dynamic> json) => ParentData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        categories: json["categories"],
        image: json["image"],
        status: json["status"],
        isInMyCart: json["is_in_my_cart"],
        isInMyCartQuantity: json["is_in_my_cart_quantity"],
        isFavourite: json["is_favourite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "categories": categories,
        "image": image,
        "status": status,
        "is_in_my_cart": isInMyCart,
        "is_in_my_cart_quantity": isInMyCartQuantity,
        "is_favourite": isFavourite,
      };
}





// // To parse this JSON data, do
// //
// //     final prefiestasDetailModel = prefiestasDetailModelFromJson(jsonString);

// import 'dart:convert';

// PrefiestasDetailModel prefiestasDetailModelFromJson(String str) =>
//     PrefiestasDetailModel.fromJson(json.decode(str));

// String prefiestasDetailModelToJson(PrefiestasDetailModel data) =>
//     json.encode(data.toJson());

// class PrefiestasDetailModel {
//   PrefiestasDetailModel({
//     this.status,
//     this.code,
//     this.data,
//   });

//   bool? status;
//   int? code;
//   Data? data;

//   factory PrefiestasDetailModel.fromJson(Map<String, dynamic> json) =>
//       PrefiestasDetailModel(
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
//     this.parentData,
//     this.childData,
//   });

//   ParentData? parentData;
//   ChildData? childData;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         parentData: ParentData.fromJson(json["parentData"]),
//         childData: ChildData.fromJson(json["childData"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "parentData": parentData?.toJson(),
//         "childData": childData?.toJson(),
//       };
// }

// class ChildData {
//   ChildData({
//     this.alcohol,
//     this.mix,
//     this.extras,
//   });

//   List<Alcohol>? alcohol;
//   List<Alcohol>? mix;
//   List<Alcohol>? extras;

//   factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
//         alcohol:
//             List<Alcohol>.from(json["alcohol"].map((x) => Alcohol.fromJson(x))),
//         mix: List<Alcohol>.from(json["mix"].map((x) => Alcohol.fromJson(x))),
//         extras:
//             List<Alcohol>.from(json["extras"].map((x) => Alcohol.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "alcohol": List<dynamic>.from(alcohol!.map((x) => x.toJson())),
//         "mix": List<dynamic>.from(mix!.map((x) => x.toJson())),
//         "extras": List<dynamic>.from(extras!.map((x) => x.toJson())),
//       };
// }

// class Alcohol {
//   Alcohol({
//     this.id,
//     this.name,
//     this.parentId,
//     this.categories,
//     this.description,
//     this.image,
//     this.price,
//     this.quantity,
//     this.isInMyCart,
//     this.isInMyCartQuantity,
//     this.isFavourite,
//   });

//   int? id;
//   String? name;
//   int? parentId;
//   String? categories;
//   String? description;
//   String? image;
//   String? price;
//   int? quantity;
//   bool? isInMyCart;
//   int? isInMyCartQuantity;
//   bool? isFavourite;

//   factory Alcohol.fromJson(Map<String, dynamic> json) => Alcohol(
//         id: json["id"],
//         name: json["name"],
//         parentId: json["parent_id"],
//         categories: json["categories"],
//         description: json["description"],
//         image: json["image"],
//         price: json["price"],
//         quantity: json["quantity"],
//         isInMyCart: json["is_in_my_cart"],
//         isInMyCartQuantity: json["is_in_my_cart_quantity"],
//         isFavourite: json["is_favourite"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "parent_id": parentId,
//         "categories": categories,
//         "description": description,
//         "image": image,
//         "price": price,
//         "quantity": quantity,
//         "is_in_my_cart": isInMyCart,
//         "is_in_my_cart_quantity": isInMyCartQuantity,
//         "is_favourite": isFavourite,
//       };
// }

// class ParentData {
//   ParentData({
//     this.id,
//     this.name,
//     this.description,
//     this.categories,
//     this.image,
//     this.status,
//     this.isInMyCart,
//     this.isInMyCartQuantity,
//     this.isFavourite,
//   });

//   int? id;
//   String? name;
//   String? description;
//   dynamic categories;
//   String? image;
//   String? status;
//   bool? isInMyCart;
//   int? isInMyCartQuantity;
//   bool? isFavourite;

//   factory ParentData.fromJson(Map<String, dynamic> json) => ParentData(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         categories: json["categories"],
//         image: json["image"],
//         status: json["status"],
//         isInMyCart: json["is_in_my_cart"],
//         isInMyCartQuantity: json["is_in_my_cart_quantity"],
//         isFavourite: json["is_favourite"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "categories": categories,
//         "image": image,
//         "status": status,
//         "is_in_my_cart": isInMyCart,
//         "is_in_my_cart_quantity": isInMyCartQuantity,
//         "is_favourite": isFavourite,
//       };
// }
