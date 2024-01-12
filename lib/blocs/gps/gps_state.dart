part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGpsEnable;
  final bool isGpsPermissionGranted;

  // PARA CAMBIO DE PANTALLA REQUIERO UN GETTER QUE VALIDE SI TOD ESTA BIEN Y ACTUE
  bool get isAllGranted => isGpsEnable && isGpsPermissionGranted;

  const GpsState(
      {required this.isGpsEnable, required this.isGpsPermissionGranted});

//copio el estado con el copy with

  GpsState copyWith({
    bool? isGpsEnable,
    bool? isGpsPermissionGranted,
  }) =>
      GpsState(
          //funcion de flecha returno implicito
          isGpsEnable: isGpsEnable ?? this.isGpsEnable,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);
  @override
  List<Object> get props => [isGpsEnable, isGpsPermissionGranted];

  //@override
   //escribo metodo para mostrar por pantalla lo tengo simplificado....
  // String toString() => '{isGpsEnable: $isGpsEnable , isGpsPermissionGranted: $isGpsPermissionGranted }';
  
}
