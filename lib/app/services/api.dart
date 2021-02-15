import 'package:flutter/material.dart';
import './api_keys.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

class API {
  final String apiKey;
  API({@required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = "ncov2019-admin.firebaseapp.com";

  Uri tokenUri() => Uri(
        host: host,
        path: 'token',
        scheme: 'https',
      );

   Uri endpointUri(Endpoint endpoint) => Uri(
        host: host,
        path: _paths[endpoint],
        scheme: 'https',
      );

  static Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}
