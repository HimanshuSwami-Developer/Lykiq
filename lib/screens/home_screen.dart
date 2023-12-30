import 'package:flutter/material.dart';
import 'package:lykiq/screens/form_screen.dart';
import 'package:lykiq/utiles/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(title: Text("Vehicle Details"),bottom: const TabBar(
              tabs: [
                Tab(text: "Bike",),      
                Tab(text: "Cars",),
              ],
            ),),
      body: Container(
        height: MediaQuery.of(context).size.height*0.67,
        child:
          TabBarView(
            children: [
               
            
              VehicleCard(Parameter: "Bike",),
              VehicleCard(Parameter: "Car"),
              
              
             
            ],
          ),
      ),
     floatingActionButton: OutlinedButton(style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40)),onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>VehicleForm()));
           },
           child: Text("Add Vehicle"),),
         
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    ),
    );
  }

}
