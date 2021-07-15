class ProductCart {
  static List ticketcart = [];
  // static Map ticketcartMap = {};

  // addTicket({String? name, int? count, int? price}) {
  //   print("add button press");
  //   ticketcart.add({
  //     "ticketname": name,
  //     "tiketCount": count,
  //     "tiketPrice": price,
  //   });

  //   print(ticketcart);
  // }

  static removeTicket() {}
}

List<TicketModel> myTickets = [];

// myTickets.add(
//     TicketModel(ticketname: "fsfdsgv", tiketCount: 1, tiketPrice: 300));

// print(myTickets..toList());
// myTickets.forEach((element) {
//   print("${element.toJson()}");
// });

class TicketModel {
  String? ticketname;
  int? tiketCount;
  int? tiketPrice;

  TicketModel({this.ticketname, this.tiketCount, this.tiketPrice});

  TicketModel.fromJson(Map<String, dynamic> json) {
    ticketname = json['ticketname'];
    tiketCount = json['tiketCount'];
    tiketPrice = json['tiketPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketname'] = this.ticketname;
    data['tiketCount'] = this.tiketCount;
    data['tiketPrice'] = this.tiketPrice;
    return data;
  }
}
