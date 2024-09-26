import 'package:flutter/material.dart';

import 'package:training_project/cubits/get_person_cubit/cubit_one.dart';
import 'package:training_project/screens/full_image.dart';
import 'package:training_project/servieces/api_get_persons.dart';

class PersonDetailScreen extends StatefulWidget {
  final int personId;

  PersonDetailScreen({super.key, required this.personId});
  final ApiGetPersons apiGetPersons = ApiGetPersons();

  @override
  State<PersonDetailScreen> createState() => _PersonDetailScreenState();
}

class _PersonDetailScreenState extends State<PersonDetailScreen> {
  @override
  void initState() {
    GetPersonCubit.get(context).getInfoperson(personId: widget.personId);
    // GetPersonCubit.get(context).getPersonImage(personId: widget.personId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Details'),
        backgroundColor: const Color.fromARGB(255, 117, 96, 96),
      ),
      body: FutureBuilder(
          future: ApiGetPersons.infoperson(personId: widget.personId),
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
            var infoPersonModel = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullImageScreen(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${infoPersonModel.profilePath}'),
                              ),
                            );
                          },
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${infoPersonModel.profilePath}',
                            height: 300,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        infoPersonModel.name ?? 'no name',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Birthday:',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            ' ${infoPersonModel.birthday?.split('1980-6-21')}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (infoPersonModel.biography != null)
                        const Text(
                          'Biography:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        ' ${infoPersonModel.biography ?? 'NO Biography'}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            );
          }),
    );
  }
}
