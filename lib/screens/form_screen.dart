import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lykiq/screens/home_screen.dart';

class VehicleForm extends StatefulWidget {
  const VehicleForm({super.key});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  TextEditingController idController = new TextEditingController();
  TextEditingController brandController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? vehicleTypeController;

  String? fuelTypeController;

  String vehicleTypeValue = 'Bike';
  var vehicleType = ['Bike', 'Car'];

  String fuelTypeValue = 'Petrol';
  var fuelType = ['Petrol', 'Diesel'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vehicle Form")),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vehicle No.",
                      style: TextStyle(fontSize: 20, fontFamily: 'mono'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: idController,
                          validator: (value) {
                            if (value!.length != 10 ) {
                              return 'Length must be 10 digit in aphlaNumeric';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Brand Name",
                      style: TextStyle(fontSize: 20, fontFamily: 'mono'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: brandController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please Enter BrandName';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Vehicle Type",
                      style: TextStyle(fontSize: 20, fontFamily: 'mono'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton(
                        // Initial Value
                        value: vehicleTypeValue,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: vehicleType.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(items)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            vehicleTypeValue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Fuel Type",
                      style: TextStyle(fontSize: 20, fontFamily: 'mono'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color: Colors.grey,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButton(
                        // Initial Value
                        value: fuelTypeValue,
      
                        padding: EdgeInsets.symmetric(horizontal: 20),
      
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
      
                        // Array list of items
                        items: fuelType.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(items)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            fuelTypeValue = newValue!;
                          });
                        },
                      ),
                    ),
                  
                  SizedBox(height: 60,),
                  Center(
                    child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Processing Data')),
                              // );
                              CollectionReference colref =
                    FirebaseFirestore.instance.collection("vehicles");
                              colref.add({
                                'brandName': brandController.text,
                                'vehicleNumber': idController.text.toUpperCase(),
                                'fuelType': fuelTypeValue,
                                'vehicleType': vehicleTypeValue,
                              });
                              Navigator.pop(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
                            }
                          },
                          child: Text("Submit"),
                        ),
                  ),
                  
                  ],
                ),
              )),
        ),
      ),
      
    );
  }
}
