import 'package:coronavirus_tracker/app/services/calls_and_message_service.dart';
import 'package:coronavirus_tracker/config/palette.dart';
import 'package:coronavirus_tracker/config/styles.dart';
import 'package:coronavirus_tracker/service_locater.dart';
import 'package:flutter/material.dart';

class BeneathAppBar extends StatelessWidget {
  
  BeneathAppBar({
    Key key,
    @required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;
  final CallsAndMessageService _service = locator<CallsAndMessageService>();

  final String number = "011-23978046";
  final String sms = "1075";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CORONA VIRUS TRACKER',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Are you feeling sick?",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "If you feel sick with any COVID-19 symptoms, please call or text immediately for help.",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () => _service.call(number),
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: const Icon(
                      Icons.phone,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Call Now',
                      style: Styles.buttonTextStyle,
                    ),
                    textColor: Colors.white,
                  ),
                  FlatButton.icon(
                    onPressed: ()  => _service.sendSms(sms),
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    icon: const Icon(
                      Icons.chat_bubble,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Send SMS',
                      style: Styles.buttonTextStyle,
                    ),
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
