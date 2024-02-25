class ModelObject {
  double basefare, taxes, total;
  String invoicenum1,
      travellername2,
      ticketnumber3,
      pnr4,
      departure5,
      arrival6,
      airlinename7,
      flightnum8,
      aircraft9,
      flightclass10,
      departureterminal11,
      arrivalterminal12,
      departuretime13,
      arrivaltime14,
      departuredate15,
      arrivaldate16;

  String due17;

  ModelObject(
      {required this.invoicenum1,
      required this.aircraft9,
      required this.airlinename7,
      required this.arrival6,
      required this.arrivaldate16,
      required this.arrivalterminal12,
      required this.arrivaltime14,
      required this.basefare,
      required this.departure5,
      required this.departuredate15,
      required this.departureterminal11,
      required this.departuretime13,
      required this.flightclass10,
      required this.flightnum8,
      required this.pnr4,
      required this.taxes,
      required this.ticketnumber3,
      required this.total,
      required this.travellername2,
          required this.due17,
      });
}
