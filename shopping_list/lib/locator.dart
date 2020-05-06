import 'package:get_it/get_it.dart';

import 'core/services/card_service.dart';
import 'core/viewmodels/card_model.dart';


GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => Api('cards'));
  locator.registerLazySingleton(() => CardCRUDModel()) ;
}