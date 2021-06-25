Future<String> zeroAdd(n) async {
  List num = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  for (int i in num) {
    if (n == i) {
      return "0$n";
    }
  }
  return "$n";
}
