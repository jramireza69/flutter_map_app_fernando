

part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory; //List<LatLng> es el mismo tipo de  objeto que importe

// constructor
  const LocationState({
    this.followingUser = false,
    this.lastKnownLocation,
    myLocationHistory
    }): myLocationHistory = myLocationHistory ?? const []; //si no lo recibo como argumento, lo voy a inicializar vacio con : despues del constructor

     LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
  }) => LocationState(
    followingUser    : followingUser ?? this.followingUser,
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory,
  );

  @override
   List<Object?> get props => [ followingUser, lastKnownLocation, myLocationHistory ]; //lista de objetos obcionales
}
