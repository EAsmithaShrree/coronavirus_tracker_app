import 'dart:io';

import 'package:coronavirus_tracker/app/repositories/endpoints_data.dart';
import 'package:coronavirus_tracker/app/services/api.dart';
import 'package:coronavirus_tracker/app/ui/beneath_app_bar.dart';
import 'package:coronavirus_tracker/app/ui/custom_app_bar.dart';
import 'package:coronavirus_tracker/app/ui/info_card.dart';
import 'package:coronavirus_tracker/app/ui/live_data_container.dart';
import 'package:coronavirus_tracker/app/ui/prevention_tips.dart';
import 'package:coronavirus_tracker/config/palette.dart';
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
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCachedData();
    _updateData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData.values[Endpoint.cases]?.date
            : null);
    return Scaffold(
      appBar: CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BeneathAppBar(
                screenHeight: screenHeight,
              ),
              //LiveDataContainer(),
              // InfoCard(endpoint:Endpoint.cases ,effectedNum: _endpointsData != null
              //   ? _endpointsData.values[Endpoint.cases]?.value
              //   : null, iconColor:Colors.orange ,),
              Container(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Palette.primaryColor.withOpacity(0.03),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    // topLeft: Radius.circular(40),
                    // topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: [
                        InfoCard(
                          endpoint: Endpoint.cases,
                          effectedNum: _endpointsData != null
                              ? _endpointsData.values[Endpoint.cases]?.value
                              : null,
                          iconColor: Colors.orange,
                        ),
                        InfoCard(
                          endpoint: Endpoint.casesConfirmed,
                          effectedNum: _endpointsData != null
                              ? _endpointsData
                                  .values[Endpoint.casesConfirmed]?.value
                              : null,
                          iconColor: Color(0xFFFF2D55),
                        ),
                        InfoCard(
                          endpoint: Endpoint.deaths,
                          effectedNum: _endpointsData != null
                              ? _endpointsData.values[Endpoint.deaths]?.value
                              : null,
                          iconColor: Color(0xFF50E3C2),
                        ),
                        InfoCard(
                          endpoint: Endpoint.recovered,
                          effectedNum: _endpointsData != null
                              ? _endpointsData.values[Endpoint.recovered]?.value
                              : null,
                          iconColor: Color(0xFF5856D6),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    LastUpdatedStatusText(
                      text: formatter.lastUpdatedStatusText(),
                    ),
                  ],
                ),
              ),
              PreventionTips(screenHeight),
            ],
          ),
        ),
        //child: OldDashboard(formatter: formatter, endpointsData: _endpointsData),
      ),
    );
  }
}

// class OldDashboard extends StatelessWidget {
//   const OldDashboard({
//     Key key,
//     @required this.formatter,
//     @required EndpointsData endpointsData,
//   })  : _endpointsData = endpointsData,
//         super(key: key);

//   final LastUpdatedDateFormatter formatter;
//   final EndpointsData _endpointsData;

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         LastUpdatedStatusText(
//           text: formatter.lastUpdatedStatusText(),
//         ),
//         for (var endpoint
//             in Endpoint.values) //iterates through every value of enum
//           EndpointCard(
//             value: _endpointsData != null
//                 ? _endpointsData.values[endpoint]?.value
//                 : null,
//             endpoint: endpoint,
//           ),
//       ],
//     );
//   }
// }
