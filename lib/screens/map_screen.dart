import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/views/views.dart';
import 'package:maps_app/widgets/witgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

//StateFulwidget se puede destruir en cualquier momento ? si el user cancela el permiso. se redibuja  MapScreen
// Screen sigue escuchando
class _MapScreenState extends State<MapScreen> {
  late LocationBloc
      locationBlock; //late en el momento en que yo lo necesite ya voy a tener un valor. porque aca no puedo poner un constructor
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locationBlock = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBlock.starFollowingUser();
  }

  @override
  void dispose() {
    // final locationBloc = BlocProvider.of<LocationBloc>(context);
    // locationBloc.getCurrentPosition();
    locationBlock.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state.lastKnownLocation == null)
          return const Center(
            child: Text('Espere por favor....'),
          );

        return SingleChildScrollView(
          child: Stack(
            children: [
              MapView(initialLocation: state.lastKnownLocation!),
            ],
          ),
        );
      },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const BtnCurrentLocation(),
      ]),
    );
  }
}
