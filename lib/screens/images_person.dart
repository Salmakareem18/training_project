import 'package:flutter/material.dart';

import 'package:training_project/cubits/get_person_cubit/cubit_one.dart';
import 'package:training_project/screens/full_image.dart';
import 'package:training_project/servieces/api_get_persons.dart';

class ImagesPerson extends StatefulWidget {
  final int personId;

  ImagesPerson({super.key, required this.personId});
  final ApiGetPersons apiGetPersons = ApiGetPersons();

  @override
  State<ImagesPerson> createState() => _ImagesPersonState();
}

class _ImagesPersonState extends State<ImagesPerson> {
  @override
  void initState() {
    GetPersonCubit.get(context).getImagesperson(personId: widget.personId);
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
          future: ApiGetPersons.imagesperson(personId: widget.personId),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('an error:${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No persons found'));
            }
            var imagesPersonModel = snapshot.data!;
            return SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imagesPersonModel.profiles!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullImageScreen(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${imagesPersonModel.profiles![index].filePath!}'),
                        ),
                      );
                    },
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w500${imagesPersonModel.profiles![index].filePath!}',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
