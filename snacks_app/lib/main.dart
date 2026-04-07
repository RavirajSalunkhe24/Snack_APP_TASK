import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/services/snack_service.dart';
import 'logic/snack_bloc/snack_bloc.dart';
import 'logic/snack_bloc/snack_event.dart';
import 'presentation/screens/snack_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => SnackBloc(SnackService())..add(FetchSnacks()),
        child: const SnackScreen(),
      ),
    );
  }
}
