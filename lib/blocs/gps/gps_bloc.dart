import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? gpsServiceSubscription;
  GpsBloc()
      : super(
            const GpsState(isGpsEnable: true, isGpsPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
        //paso los valores del nuevvo evento
        isGpsEnable: event.isGpsEnable,
        isGpsPermissionGranted: event.isGpsPermissionGranted)));

    _init(); //emito nuevo estado
  }

  

  Future<void> _init() async {
    final isEnable = await _checkGpsStatus(); //cuando la app se crea se carga
    final isGranted =
        await _isPermissionGranted(); //los dos deben quedar en true.  se piden de manera asincrona primero uno y luego el otro
    print('isEnable: $isEnable , isGranted: $isGranted ');

    //  disparar los Futere de manera simultanea, retorna un listado de bool

   /*  final gpsInitStatus = await Future.wait({
       _checkGpsStatus(),
       _isPermissionGranted(),

       se llamaria  
       isGpsEnable:  gpsInitStatus[0],
        isGpsPermissionGranted: gpsInitStatus[1]
    }); */

    add(GpsAndPermissionEvent(
        isGpsEnable: isEnable,
        // isGpsPermissionGranted: state.isGpsPermissionGranted)); antes
        isGpsPermissionGranted: isGranted));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission
        .location.isGranted; //no lo pide solo verifica el estado
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = Geolocator
        .isLocationServiceEnabled(); //reviso si el servicio esta habilitado

    gpsServiceSubscription =
        Geolocator.getServiceStatusStream().listen((event) {
      final isEnable = (event.index == 1) ? true : false;
      print('isEnablemobil $isEnable  ');

      add(GpsAndPermissionEvent(
          isGpsEnable: isEnable,
          isGpsPermissionGranted: state.isGpsPermissionGranted));
    });
    return isEnable;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(
            isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(
            isGpsEnable: state.isGpsEnable, isGpsPermissionGranted: false));
        openAppSettings();
        break;
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
