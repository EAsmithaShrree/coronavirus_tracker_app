import 'package:coronavirus_tracker/service_locater.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './app/services/api_service.dart';
import './app/services/api.dart';

import './app/repositories/data_repository.dart';

import './app/ui/dashboard.dart';

import './app/services/data_cache_service.dart';

import './app/ui/screens/main_screen.dart';
void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MyApp(
      sharedPreferences: sharedPreferences,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(
          api: API.sandbox(),
        ),
        dataCacheService:
            DataCacheService(sharedPreferences: sharedPreferences),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        //theme: ThemeData.dark(),
        home: Dashboard(),
        //home: MainScreen(),
      ),
    );
  }
}
