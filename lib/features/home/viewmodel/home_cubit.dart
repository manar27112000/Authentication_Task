import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../model/home_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void fetchClothes()async{
    try{
      emit(HomeLoadingState());
      Response response = await Dio().get('https://fakestoreapi.com/products',);
      if(response.statusCode == 200){

        List<dynamic> data = response.data;

        List<HomeModel> clothes = data
            .map((json) => HomeModel.fromJson(json))
            .toList();

        emit(HomeSuccessState( homeModel: clothes));
      }

      else{
        emit(HomeErrorState(error: " يوجد خطا في استقبال الداتا"));
      }

    }catch (e){
      emit(HomeErrorState(error: e.toString()));
    }
  }

}
