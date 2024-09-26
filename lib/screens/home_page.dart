import 'package:flutter/material.dart';
import 'package:training_project/models/person_model.dart';
import 'package:training_project/screens/person_details.dart';
import 'package:training_project/servieces/api_get_persons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiGetPersons apiGetPersons = ApiGetPersons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 117, 96, 96),
          title: const Text('Famous Persons'),
          leading: const Icon(Icons.person),
        ),
        body: FutureBuilder<PopularModel>(
            future: apiGetPersons.famousPerson(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('an error:${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No persons found'));
              }
              var popularModel = snapshot.data!;
              return ListView.builder(
                itemCount: popularModel.results!.length,
                itemBuilder: (context, index) {
                  final person = popularModel.results![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PersonDetailScreen(
                            personId: int.parse(person.id.toString()),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 16, right: 16, top: 16),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 117, 96, 96),
                            borderRadius: BorderRadius.circular(15)),
                        width: 100,
                        height: 100,
                        child: Center(
                            child: Text(
                          person.name ?? 'Unknown',
                          style: const TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  );
                },
              );
            }));
  }
}
