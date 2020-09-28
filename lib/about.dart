import 'package:flutter/material.dart';

Future<void> aboutBubble(BuildContext context) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Text("Bubble"),
            Icon(Icons.bubble_chart)
          ],),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "Bubble multi-purpose liquid detergent",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "is a pleasantly scented homemade liquid detergent with maximum cleaning power."),
                SizedBox(height: 10,),
                Text("Bubble liquid detergent is all-purpose: can be used for laundry, dishwashing, cleaning surfaces and other cleanings."),
                SizedBox(height: 10,),
                Text("With bubble liquid detergent, you get to enjoy good quality at an affordable price:"),
                SizedBox(height: 10,),
                Text("4 litres for ₦1,200"),
                SizedBox(height: 10,),
                Text("2 litres for ₦600"),
                SizedBox(height: 10),
                Text("Order your bubble multi-purpose liquid soap here, payments should be made on delivery."),
                SizedBox(height: 10),
                Text("For further enquiries, contact", style: TextStyle(fontStyle: FontStyle.italic)),
                SizedBox(height: 10),
                Row(children: [
                  Icon(Icons.phone, size: 20,),
                  SelectableText("+234xxxxxxxxx"),
                ],)
                
              ],
            ),
          ),
        );
      });
}
