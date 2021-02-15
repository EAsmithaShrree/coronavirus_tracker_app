import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/api.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;
  EndpointCard({Key key, this.endpoint, this.value});

  static Map<Endpoint, String> _cardTitles = {
    Endpoint.cases: 'Cases',
    Endpoint.casesConfirmed: 'Cases Confirmed',
    Endpoint.casesSuspected: 'Cases Suspected',
    Endpoint.deaths: 'Deaths',
    Endpoint.recovered: 'Recovered',
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _cardTitles[endpoint],
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                formattedValue,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
