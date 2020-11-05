import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> aboutBubble(BuildContext context) {
  makeCall() async {
    const number = 'tel:+2349039197553';
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'could not dial $number';
    }
  }

  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [Text("Bubble"), Icon(Icons.bubble_chart)],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "Bubble multi-purpose liquid detergent",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "is a pleasantly scented homemade liquid detergent with maximum cleaning power."),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "Bubble liquid detergent is all-purpose: can be used for laundry, dishwashing, cleaning surfaces and other cleanings."),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "With bubble liquid detergent, you get to enjoy good quality at an affordable price:"),
                SizedBox(
                  height: 10,
                ),
                Text("75cl for ₦200"),
                SizedBox(
                  height: 10,
                ),
                Text("2 litres for ₦500"),
                SizedBox(height: 10),
                Text("5 litres for ₦1,200"),
                SizedBox(height: 10),
                Text(
                    "Order your bubble multi-purpose liquid soap here, payments should be made on delivery."),
                SizedBox(height: 10),
                RichText(text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'N.B: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Non-inclusion of a timeframe is assumed that you are available at any time.')
                  ]
                )),
                SizedBox(height: 10),
                Text("For further enquiries, contact",
                    style: TextStyle(fontStyle: FontStyle.italic)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 20,
                      color: Colors.blue,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        child: Text(
                          "+2349039197553",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600),
                        ),
                        onTap: makeCall,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
