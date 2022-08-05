import 'package:bloc/bloc.dart';
import 'package:flutter_app/models/shop_app/search_model.dart';
import 'package:flutter_app/modules/shop_app/search/cubit/states.dart';
import 'package:flutter_app/networks/end_points.dart';
import 'package:flutter_app/networks/remote/dio_helper.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(SearchStates initialState) : super(initialState);

  static SearchCubit get(context)=>BlocProvider.of(context);

  searchModel model;

  void search(String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value)
    {
      model = searchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}