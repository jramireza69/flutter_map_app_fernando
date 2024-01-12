part of 'location_bloc.dart';

 class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}
//creo evento que me permita a mi recibir  una nueva ubicacion... se ubica aqui y se añade a mylocationhistory
class OnNewUserLocationEvent extends LocationEvent {
  final LatLng newLocation;
  const OnNewUserLocationEvent(this.newLocation); // queda en forma posicional ({this.newLocation}) porque uno asi y el otro con parentesis... esta forma en para recibir varias propiedaes 
}

class OnStartFollowingUser extends LocationEvent {}
class OnStopFollowingUser  extends LocationEvent {}
