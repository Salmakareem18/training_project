import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:training_project/cubits/get_person_cubit/states.dart';
import 'package:training_project/models/images_person_model.dart';
import 'package:training_project/models/info_person_model.dart';
import 'package:training_project/servieces/api_get_persons.dart';

class GetPersonCubit extends Cubit<PersonState> {
  String baseimagesurl = 'http://image.tmdb.org/t/p/w500/';
  GetPersonCubit() : super(PersonInitial());
  static GetPersonCubit get(context) => BlocProvider.of(context);
  InfoPersonModel infoPersonModel = InfoPersonModel();
  ImagesPersonModel imagesPersonModel = ImagesPersonModel();
  getInfoperson({required int personId}) async {
    try {
      emit(PersonLoading());
      final personDetails = await ApiGetPersons.infoperson(personId: personId);

      emit(PersonLoadedState(
        personDetails: personDetails.toJson(),
      ));
    } catch (e) {
      emit(PersonfailureState(errormessage: ' try again: $e'));
    }
  }

  getImagesperson({required int personId}) async {
    try {
      emit(ImagesLoading());
      final images = await ApiGetPersons.getimagesperson(personId: personId);
      emit(ImagesLoadedState(imagesperson: images.profiles!));
    } catch (e) {
      emit(ImagesfailureState(errormessage: ' try again: $e'));
    }
  }
}
