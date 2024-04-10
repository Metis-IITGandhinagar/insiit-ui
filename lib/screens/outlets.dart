
import 'package:flutter/material.dart';

import '../widgets/outlet_explore.dart';
import '../widgets/outlets.dart';
import '../widgets/outlet_order.dart';

class OutletScreen extends StatefulWidget {
  const OutletScreen({super.key});

  @override
  State<OutletScreen> createState() => _OutletScreenState();
}

class _OutletScreenState extends State<OutletScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:Theme.of(context).colorScheme.secondaryContainer,
        title: const Text(
          "Outlets",
          style: TextStyle(fontSize: 22),
        ),
      ),
      body:
      
       Container(        
          alignment: Alignment.center,
          child: OutletExplore(),
        ),
       
     
          
     
      );
   
  }
}