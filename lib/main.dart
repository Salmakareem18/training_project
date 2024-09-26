import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_project/cubits/get_person_cubit/cubit_one.dart';
import 'package:training_project/screens/home_page.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<GetPersonCubit>(
        create: (context) => GetPersonCubit(),
      ),
    ],
    child: const Informations(),
  ));
}

class Informations extends StatelessWidget {
  const Informations({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
