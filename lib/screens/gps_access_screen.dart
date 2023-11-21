import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            print('state: $state');
            return !state.isGpsEnable
                ? const _EnableGpsMessage()
                : const _AccessButton();
          },
        ),
        // child: _AccessButton(),
        // child: _EnableGpsMessage(),
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es nececesario el acceso al gps'),
        MaterialButton(
            color: Colors.black,
            shape: const StadiumBorder(),
            onPressed: () {
              final gpsBlocOpen = BlocProvider.of<GpsBloc>(context);
              gpsBlocOpen.askGpsAccess();
            },
            child: const Text('Solicitar acceso',
                style: TextStyle(color: Colors.white)))
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Debe habilitar el gps',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
    );
  }
}
