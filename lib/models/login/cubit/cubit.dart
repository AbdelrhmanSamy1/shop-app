import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_app/networks/end_points.dart';
import 'package:flutter_app/networks/local/cache_helper.dart';
import 'package:flutter_app/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
})
  {
    emit(ShopLoginLoadingState());

    DioHelper.postData(
      url:LOGIN,
      lang: 'en',
      data: {
        email:'email',
        password:'password',
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      if(loginModel.status){
        print(loginModel.status);
        print(loginModel.message);
        print(loginModel.data.token);
        CacheHelper.saveData(key: 'token', value: loginModel.data.token);
        emit(ShopLoginSuccessState(loginModel));
      }else{
        emit(ShopLoginSuccessState(loginModel));
      }
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;


  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopChangePasswordVisibilityState());
  }
}
