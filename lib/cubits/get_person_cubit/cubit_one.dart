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
  ImagesModel imagesModel = ImagesModel();
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
      final images = await ApiGetPersons.imagesperson(personId: personId);
      emit(ImagesLoadedState());
    } catch (e) {
      emit(ImagesfailureState(errormessage: ' try again: $e'));
    }
  }
}
