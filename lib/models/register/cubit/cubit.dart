import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_app/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_app/networks/end_points.dart';
import 'package:flutter_app/networks/local/cache_helper.dart';
import 'package:flutter_app/networks/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({
    @required String name,
    @required String email,
    @required String password,
    @required String phone,
  })
  {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(
      url:REGISTER,
      data: {
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      if(loginModel.status){
        print(loginModel.status);
        print(loginModel.message);
        print(loginModel.data.token);
        CacheHelper.saveData(key: 'token', value: loginModel.data.token);
        emit(ShopRegisterSuccessState(loginModel));
      }else{
        emit(ShopRegisterSuccessState(loginModel));
      }
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;


  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
