import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/loading_screen.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (contex) => GpsBloc()) //creo una instancia en mi contexto de gpsblock
  ], 
  child: const MyApp(),
  )
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: LoadingScreen()
      );
    
  }
}