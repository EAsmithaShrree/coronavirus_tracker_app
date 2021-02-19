import 'package:get_it/get_it.dart';

import 'app/services/calls_and_message_service.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerSingleton(
    CallsAndMessageService(),
  );
}
