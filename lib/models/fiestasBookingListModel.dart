class FiestasBookingList {
  bool? status;
  int? code;
  Data? data;

  FiestasBookingList({this.status, this.code, this.data});

  FiestasBookingList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<DataListFiesta>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new DataListFiesta.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class DataListFiesta {
  int? id;
  int? userId;
  int? fiestaId;
  String? totalPrice;
  Null paymentParams;
  Null paymentMode;
  String? bookingStatus;
  Null params;
  String? status;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  FiestaDetail? fiestaDetail;

  DataListFiesta(
      {this.id,
      this.userId,
      this.fiestaId,
      this.totalPrice,
      this.paymentParams,
      this.paymentMode,
      this.bookingStatus,
      this.params,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.fiestaDetail});

  DataListFiesta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    fiestaId = json['fiesta_id'];
    totalPrice = json['total_price'];
    paymentParams = json['payment_params'];
    paymentMode = json['payment_mode'];
    bookingStatus = json['booking_status'];
    params = json['params'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    fiestaDetail = json['fiesta_detail'] != null
        ? new FiestaDetail.fromJson(json['fiesta_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['fiesta_id'] = this.fiestaId;
    data['total_price'] = this.totalPrice;
    data['payment_params'] = this.paymentParams;
    data['payment_mode'] = this.paymentMode;
    data['booking_status'] = this.bookingStatus;
    data['params'] = this.params;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.fiestaDetail != null) {
      data['fiesta_detail'] = this.fiestaDetail?.toJson();
    }
    return data;
  }
}

class FiestaDetail {
  int? id;
  String? name;
  int? clubId;
  String? timestamp;
  Null image;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? distanceKm;
  String? distanceMiles;
  ClubDetail? clubDetail;

  FiestaDetail(
      {this.id,
      this.name,
      this.clubId,
      this.timestamp,
      this.image,
      this.ticketPrice,
      this.ticketPriceStandard,
      this.ticketPriceVip,
      this.totalMembers,
      this.dressCode,
      this.partyMusic,
      this.distanceKm,
      this.distanceMiles,
      this.clubDetail});

  FiestaDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clubId = json['club_id'];
    timestamp = json['timestamp'];
    image = json['image'];
    ticketPrice = json['ticket_price'];
    ticketPriceStandard = json['ticket_price_standard'];
    ticketPriceVip = json['ticket_price_vip'];
    totalMembers = json['total_members'];
    dressCode = json['dress_code'];
    partyMusic = json['party_music'];
    distanceKm = json['distance_km'];
    distanceMiles = json['distance_miles'];
    clubDetail = json['club_detail'] != null
        ? new ClubDetail.fromJson(json['club_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['club_id'] = this.clubId;
    data['timestamp'] = this.timestamp;
    data['image'] = this.image;
    data['ticket_price'] = this.ticketPrice;
    data['ticket_price_standard'] = this.ticketPriceStandard;
    data['ticket_price_vip'] = this.ticketPriceVip;
    data['total_members'] = this.totalMembers;
    data['dress_code'] = this.dressCode;
    data['party_music'] = this.partyMusic;
    data['distance_km'] = this.distanceKm;
    data['distance_miles'] = this.distanceMiles;
    if (this.clubDetail != null) {
      data['club_detail'] = this.clubDetail?.toJson();
    }
    return data;
  }
}

class ClubDetail {
  int? id;
  String? name;
  String? image;
  String? capacity;
  String? description;
  String? location;
  Null latitude;
  Null longitude;

  ClubDetail(
      {this.id,
      this.name,
      this.image,
      this.capacity,
      this.description,
      this.location,
      this.latitude,
      this.longitude});

  ClubDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    capacity = json['capacity'];
    description = json['description'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['description'] = this.description;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
