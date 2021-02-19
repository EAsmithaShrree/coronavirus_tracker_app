import 'package:coronavirus_tracker/config/data.dart';
import 'package:flutter/material.dart';

class PreventionTips extends StatelessWidget {
  final screenHeight;
  PreventionTips(this.screenHeight);
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.orange,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              "Prevention Tips",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: prevention
                .map(
                  (e) => Column(
                    children: [
                      Image.asset(
                        e.keys.first,
                        height: screenHeight * 0.12,
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        e.values.first,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
