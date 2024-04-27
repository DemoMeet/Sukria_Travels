import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_management/Screens/travelerModel.dart';
import 'package:customer_management/modeel.dart';
import 'package:customer_management/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:customer_management/pdf_helper.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../AppBar.dart';
import '../widgets/customer_model.dart';

class InputFieldScreen extends StatefulWidget {
  const InputFieldScreen({super.key});

  @override
  State<InputFieldScreen> createState() => _InputFieldScreenState();
}

class _InputFieldScreenState extends State<InputFieldScreen> {
  List<customerModel> allcustomer = [];
  List<travellerModel> traveller = [];
  final _invoicenum1 = TextEditingController();
  final _travellername2 = TextEditingController();
  final _ticketnumber3 = TextEditingController();
  final _pnr4 = TextEditingController();
  final _departure5 = TextEditingController();
  final _arrival6 = TextEditingController();
  final _airlinename7 = TextEditingController();
  final _flightnum8 = TextEditingController();
  final _aircraft9 = TextEditingController();
  final _flightclass10 = TextEditingController();
  final _departureterminal11 = TextEditingController();
  final _arrivalterminal12 = TextEditingController();
  final _departuretime13 = TextEditingController();
  final _arrivaltime14 = TextEditingController();
  final _departuredate15 = TextEditingController();
  final _arrivaldate16 = TextEditingController();
  final _basefare17 = TextEditingController();
  final _taxes18 = TextEditingController();
  final _due19 = TextEditingController();

  customerModel? _selectedCustomer;
  String? _travellerType;
  Future<void> _fetch() async {
    traveller.add(travellerModel(
        name: TextEditingController(),
        price: TextEditingController(),
        ticketnumber: TextEditingController(),
        type: null));
    await FirebaseFirestore.instance
        .collection('customers')
        .get()
        .then((querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          allcustomer.add(customerModel(
            due: element["due"],
            email: element["email"],
            permanentAddress: element["permanentAddress"],
            presentAddress: element["presentAddress"],
            id: element.id,
            name: element["name"],
            phone: element["phone"],
          ));
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetch();
  }

  void decreaseDueAmount(String documentId, double amountToDecrease) async {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection('customers').doc(documentId);
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      double currentDue = documentSnapshot['due'] ?? 0.0;
      double newDue = currentDue + amountToDecrease;
      await documentReference.update({'due': newDue});
      print('Due amount decreased successfully!');
    } else {
      print('Document does not exist.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    _addtoTraveller() {
      setState(() {
        traveller.add(travellerModel(
            name: TextEditingController(),
            price: TextEditingController(),
            ticketnumber: TextEditingController(),
            type: null));
      });
    }

    _removeTraveller(int index) {
      setState(() {
        if(!(traveller.length==1)){
        traveller.removeAt(index);}
      });
    }

    Future<void> _uploadInvoiceDetails() async {
      try {
        if (_selectedCustomer == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please Select A Customer..'),
            ),
          );
        } else {
          await FirebaseFirestore.instance.collection('invoice').add({
            'invoicenumber': _invoicenum1.text,
            'traverllername': _travellername2.text,
            'ticketnumber': _ticketnumber3.text,
            'pnr': _pnr4.text,
            'departure': _departure5.text,
            'arrival': _arrival6.text,
            'airlinename': _airlinename7.text,
            'flightnum': _flightnum8.text,
            'aircraft': _aircraft9.text,
            'flightclass1': _flightclass10.text,
            'departureterminal': _departureterminal11.text,
            'arrivalterminal': _arrivalterminal12.text,
            'departuretime': _departuretime13.text,
            'arrivaltime': _arrivaltime14.text,
            'departuredate': _departuredate15.text,
            'arrivaldate': _arrivaldate16.text,
            'basefare': double.parse(_basefare17.text),
            'taxes': double.parse(_taxes18.text),
            'selectedCustomerid': _selectedCustomer!.id.toString(),
            'selectedCustomer': _selectedCustomer!.name.toString(),
            'travellerType': _travellerType.toString() ?? '',
          }).then((value) {
            decreaseDueAmount(_selectedCustomer!.id,
                double.parse(_basefare17.text) + double.parse(_taxes18.text));
            Get.offNamed(invoiceList);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Customer details updated'),
              ),
            );
          });
        }
      } catch (e) {
        print('Error uploading customer details: $e');
      }
    }

    return Scaffold(
      appBar: myAppBar(context, _width),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Flight Invoice",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Invoice Number",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Customer Name",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _invoicenum1,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Invoice Number",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: DropdownButtonFormField<customerModel>(
                          value: _selectedCustomer,
                          items: allcustomer.map((customer) {
                            return DropdownMenuItem<customerModel>(
                              value: customer,
                              child: Text(customer.name),
                            );
                          }).toList(),
                          onChanged: (customerModel? value) {
                            _selectedCustomer = value;
                            _due19.text = _selectedCustomer!.due.toString();
                          },
                          decoration: InputDecoration(
                            hintText: 'Select Customer',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            "Travellers",
                            style: TextStyle(fontSize: 16),
                          ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green, // Change the background color here
                          borderRadius: BorderRadius.circular(25), // Optional: Add border radius for rounded corners
                        ),
                        child: IconButton(
                          onPressed: () {
                            _addtoTraveller();
                          },
                          icon: const Icon(
                            Icons.add,size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red, // Change the background color here
                          borderRadius: BorderRadius.circular(25), // Optional: Add border radius for rounded corners
                        ),
                        child: IconButton(
                          onPressed: () {
                            _removeTraveller(traveller.length-1);
                          },
                          icon: const Icon(
                            Icons.delete_outline,size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: (215 * (traveller.length)).toDouble(),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: traveller.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(top: 5, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "${index+1}. Traveller Name",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 1,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "${index+1}. Traveller Type",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: TextFormField(
                                      controller: traveller[index].name,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        hintText: "Traveller Name",
                                        fillColor: Colors.grey[200],
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 1,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: DropdownButtonFormField<String>(
                                      value: traveller[index].type,
                                      onChanged: (newValue1) {
                                        setState(() {
                                          traveller[index].type = newValue1!;
                                        });
                                      },
                                      items: <String>[
                                        'Pensioner',
                                        'Adult',
                                        'Youth',
                                        'Children',
                                        'Infant'
                                      ].map<DropdownMenuItem<String>>(
                                          (String newValue1) {
                                        return DropdownMenuItem<String>(
                                          value: newValue1,
                                          child: Text(newValue1),
                                        );
                                      }).toList(),
                                      decoration: InputDecoration(
                                        hintText: "Select",
                                        fillColor: Colors.grey[200],
                                        filled: true,
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "${index +1}. Ticket Number",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 1,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Text(
                                      "${index + 1}. Ticket Price",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 10,
                                    child: TextFormField(
                                      controller: traveller[index].ticketnumber,
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        hintText: "Ticket Number",
                                        fillColor: Colors.grey[200],
                                        filled: true,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 1,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: TextFormField(
                                      controller: traveller[index].price,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide: BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                          borderSide:
                                              BorderSide(color: Colors.blue),
                                        ),
                                        hintText: "Ticket Price",
                                        fillColor: Colors.grey[200],
                                        filled: true,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Departure",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Arrival",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _departure5,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Departure",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _arrival6,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Arrival",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Airline Name",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Flight Number",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _airlinename7,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Airline Name",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _flightnum8,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Flight Number",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Aircraft",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Flight Class",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _aircraft9,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Aircraft",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _flightclass10,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Flight Class",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Departure Terminal",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Arrival Terminal",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _departureterminal11,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Departure Terminal",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _arrivalterminal12,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Arrival Terminal",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Departure Time",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Arrival Time",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _departuretime13,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Departure Time",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _arrivaltime14,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Arrival Time",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Departure Date",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Arrival Date",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _departuredate15,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Departure Date",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _arrivaldate16,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Arrival Date",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Base Fare",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Taxes, Surcharge & Fees",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _basefare17,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Base Fare",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _taxes18,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "Taxes, Surcharge & Fees",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Due",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _due19,
                          decoration: InputDecoration(
                            hintText: "Due",
                            fillColor: Colors.grey[200],
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                          readOnly: true,
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          // controller: _arrivalterminal12,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            hintText: "",
                            fillColor: Colors.grey[200],
                            filled: false,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: _width / 8,
                        margin: const EdgeInsets.only(
                          bottom: 40,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            double bbb = double.parse(_basefare17.text);
                            double ttt = double.parse(_taxes18.text);
                            double due = double.parse(_due19.text);
                            double total = bbb + ttt + due;
                            _uploadInvoiceDetails();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2772),
                            elevation: 20,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
