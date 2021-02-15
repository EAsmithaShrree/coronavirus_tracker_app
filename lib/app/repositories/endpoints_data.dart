import 'package:coronavirus_tracker/app/services/endpoint_data.dart';
import 'package:flutter/material.dart';

import '../services/api.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoint, EndpointData> values;

  EndpointData get cases => values[Endpoint.cases];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get recovered => values[Endpoint.recovered];
  EndpointData get deaths => values[Endpoint.deaths];

  @override
  String toString() =>
      'cases: $cases, suspected : $casesSuspected, confirmed: $casesConfirmed, deaths : $deaths, recovered : $recovered';
}
