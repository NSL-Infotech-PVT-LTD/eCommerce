Future<String> zeroAdd(n) async {
  List num = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  for (int i in num) {
    if (n == i) {
      return "0$n";
    }
  }
  return "$n";
}

// 2021-04-15
Future<String?> dateFormat({DateTime? date}) async {
  String year = "${date?.year}";

  var month = await zeroAdd(date?.month);

  var day = await zeroAdd(date?.day);

  // ignore: unnecessary_statements

  return "$year-$month-$day";
}
