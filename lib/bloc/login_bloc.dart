import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../api/api_service.dart';
import '../services/notification_service.dart';
import '../services/location_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  final NotificationService notificationService;
  final LocationService locationService;

  LoginBloc(this.apiService, this.notificationService, this.locationService) : super(LoginInitial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        bool isSuccess = await apiService.login(event.username, event.password);
        if (isSuccess) {
          await notificationService.initialize();

          // Get and send the location after successful login
          Position position = await locationService.getLocation();
          await apiService.sendLocation(position.latitude, position.longitude);

          yield LoginSuccess();
        }
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    }
  }
}
