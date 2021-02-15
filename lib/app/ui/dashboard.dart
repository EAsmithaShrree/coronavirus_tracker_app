import 'dart:io';

import 'package:coronavirus_tracker/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './endpoint_card.dart';

import '../repositories/data_repository.dart';

import './last_updated_status_text.dart';
import './show_alert_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;
  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() {
        _endpointsData = endpointsData;
      });
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: "Connection Error",
        content: "Could not retrieve data, please try again later.",
        defaultActionText: 'Okay',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: "Unknown Error",
        content: "Please contact support or try again later.",
        defaultActionText: 'Okay',
      );
    }
  }

  @override
  void initState() {
    final dataRepository=Provider.of<DataRepository>(context,listen:false);
    _endpointsData=dataRepository.getAllEndpointsCachedData();
    _updateData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData.values[Endpoint.cases]?.date
            : null);
    return Scaffold(
      appBar: AppBar(
        title: Text("Corona Virus Tracker"),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint
                in Endpoint.values) //iterates through every value of enum
              EndpointCard(
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
                endpoint: endpoint,
              ),
          ],
        ),
      ),
    );
  }
}
