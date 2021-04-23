import 'package:buyerapp/authentication/auth.dart';
import'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUpServices(){
  locator.registerSingleton<Auth>(Auth());
}