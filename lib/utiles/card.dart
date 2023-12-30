import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VehicleCard extends StatefulWidget {
  String Parameter;
  VehicleCard({super.key, required this.Parameter});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  String? bike;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("vehicles").snapshots(),
          builder: (context, snapshot) {
            List<Column> vehicleContainers = [];

            if (snapshot.hasData) {
              final vehicles = snapshot.data!.docs.reversed.toList();
              for (var vehicle in vehicles) {
                if (vehicle['vehicleType'] == widget.Parameter) {
                  final vehicleContainer = Column(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              
                              height: MediaQuery.of(context).size.height * 0.28,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 40,right:20),
                                    child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'vehicleNumber :',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            vehicle['vehicleNumber'],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'brandName :',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            vehicle['brandName'],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'vehicleType :',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            vehicle['vehicleType'],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'fuelType :',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            vehicle['fuelType'],
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                                                  ),
                                  ),
                                  
                                  Positioned(right:2,top: 0,child: IconButton(onPressed: (){
                                    var collection=FirebaseFirestore.instance.collection('vehicles');
                                    collection.doc(vehicle.id).delete();
                                  }, icon: Icon(Icons.delete_forever)))
                               
                                ]
                              )),
                        ),
                      ),
                    ],
                  );

                  vehicleContainers.add(vehicleContainer);
                  bike = vehicle['vehicleType'];
                }
              }
            }

            if (bike == 'Bike')
              return ListView(children: vehicleContainers);
            else if (bike == 'Car')
              return ListView(children: vehicleContainers);
            else
              return  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_bike),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "No Vehicles",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    );
                 
                  }),
    );
  }
}
