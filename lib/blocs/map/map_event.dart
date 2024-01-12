part of 'map_bloc.dart';

class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class onMapInitializeEvent extends MapEvent {
  final GoogleMapController controller;

  const onMapInitializeEvent(this.controller);

}
