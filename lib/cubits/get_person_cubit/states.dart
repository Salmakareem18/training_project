import 'package:training_project/models/images_person_model.dart';

class PersonState {}

class PersonInitial extends PersonState {}

class PersonLoading extends PersonState {}

class PersonLoadedState extends PersonState {
  final Map<String, dynamic> personDetails;

  PersonLoadedState({required this.personDetails});
}

class PersonfailureState extends PersonState {
  final String errormessage;

  PersonfailureState({required this.errormessage});
}

class ImagesLoading extends PersonState {}

class ImagesLoadedState extends PersonState {
  final List<Profiles> imagesperson;
  ImagesLoadedState({required this.imagesperson});
}

class ImagesfailureState extends PersonState {
  final String errormessage;

  ImagesfailureState({required this.errormessage});
}
