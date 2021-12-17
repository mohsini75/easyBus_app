class Parent {
  final String RegNo;
  final String password;
  List<String> rideHistory;
  Map<String, String> transactions;

  Parent(
      {required this.RegNo,
      required this.password,
      required this.rideHistory,
      required this.transactions});
}
