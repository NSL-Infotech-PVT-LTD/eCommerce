class FistaBooking {
  bool? status;
  int? code;
  Data? data;

  FistaBooking({this.status, this.code, this.data});

  FistaBooking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<DataFista>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
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
        data!.add(new DataFista.fromJson(v));
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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

class DataFista {
  int? id;
  String? name;
  int? clubId;
  String? timestamp;
  var image;
  String? ticketPrice;
  String? ticketPriceStandard;
  String? ticketPriceVip;
  String? totalMembers;
  String? dressCode;
  String? partyMusic;
  String? distanceKm;
  String? distanceMiles;

  DataFista(
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
      this.distanceMiles});

  DataFista.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
