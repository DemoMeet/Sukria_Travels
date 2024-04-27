class InvoiceModel {
  String invoicenumber;
  String departure;
  String arrival;
  String airlinename;
  String flightnum;
  String departureterminal;
  String arrivalterminal;
  String departuretime;
  String arrivaltime;
  String departuredate;
  String arrivaldate;
  double basefare;
  String selectedCustomerid;
  String selectedCustomer;
  String selectedCustomerphone;
  List<Map<String, dynamic>> travellers;

  InvoiceModel({
    required this.invoicenumber,
    required this.departure,
    required this.arrival,
    required this.airlinename,
    required this.flightnum,
    required this.departureterminal,
    required this.arrivalterminal,
    required this.departuretime,
    required this.arrivaltime,
    required this.departuredate,
    required this.arrivaldate,
    required this.basefare,
    required this.selectedCustomerid,
    required this.selectedCustomer,
    required this.selectedCustomerphone,
    required this.travellers,
  });
}