import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/config/palette.dart';
import 'package:flutter/material.dart';

import 'info_card.dart';

class LiveDataContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.primaryColor.withOpacity(0.03),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: Wrap(
        children: [
          InfoCard(
            endpoint: Endpoint.cases,
            iconColor: Color(0xFFFF9C00),
            effectedNum: 1062,
          ),
        ],
      ),
    );
  }
}
