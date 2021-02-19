import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:flutter/material.dart';

import 'line_report_chart.dart';

class InfoCard extends StatelessWidget {
  final Endpoint endpoint;
  final int effectedNum;
  final Color iconColor;
  static Map<Endpoint, String> _cardTitles = {
    Endpoint.cases: 'Cases',
    Endpoint.casesConfirmed: 'Cases Confirmed',
    Endpoint.casesSuspected: 'Cases Suspected',
    Endpoint.deaths: 'Deaths',
    Endpoint.recovered: 'Recovered',
  };
  const InfoCard({
    Key key,
    @required this.endpoint,
    @required this.effectedNum,
    @required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth / 2 - 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Text(''),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      _cardTitles[endpoint],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: "$effectedNum\n",
                              style: TextStyle(
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'People',
                              style: TextStyle(
                                fontSize: 12,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: LineReportChart(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
