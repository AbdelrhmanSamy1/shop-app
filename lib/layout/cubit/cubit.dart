
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/shop_app/cubit/states.dart';
import 'package:flutter_app/models/shop_app/categories_model.dart';
import 'package:flutter_app/models/shop_app/change_favorites_model.dart';
import 'package:flutter_app/models/shop_app/favorite_model.dart';
import 'package:flutter_app/models/shop_app/home_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/modules/shop_app/categories/categories.dart';
import 'package:flutter_app/modules/shop_app/favorites/favorites.dart';
import 'package:flutter_app/modules/shop_app/products/products.dart';
import 'package:flutter_app/modules/shop_app/settings/settings.dart';
import 'package:flutter_app/networks/end_points.dart';
import 'package:flutter_app/networks/remote/dio_helper.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index)
  {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  ShopHomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = ShopHomeModel.fromMap(value.data);
      printFullText(homeModel.toString());
      print(homeModel.data.banners[0].image);
      print(homeModel.status);

      homeModel.data.products.forEach((element)
      {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      // print('getData error=>${error.toString()}');
      emit(ShopErrorHomeDataState());

    });
  }

  CategoriesModel categoriesModel;

  void getCategories()
  {

    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromMap(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error){
      print('error=>${error.toString()}');
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId)
  {
    favorites[productId] =! favorites[productId];

    emit(ShopSuccessChangeState());

    DioHelper.postData(
        url: FAVORITES,
        data:
        {
          'product_id' : productId,
        },
      token: token,
    ).then((value)
    {
      changeFavoritesModel = ChangeFavoritesModel.fromMap(value.data);
      print(value.data);

      if(!changeFavoritesModel.status)
        {
          favorites[productId] = !favorites[productId];
        }else
          {
            getFavorits();
          }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    })
        .catchError((error){
      favorites[productId] =! favorites[productId];
      print('favorite error=>${error.toString()}');
          emit(ShopErrorChangeFavoritesState());

    });
  }

  FavoritesModel favoritesModel;

  void getFavorits()
  {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){
      print('getData error=>${error.toString()}');
      emit(ShopErrorGetFavoritesState(error));
    });
  }
  LoginModel userModel;

  void getUserData(){
    emit(ShopLoadingGetProfileState ());
    DioHelper.getData(
      url:PROFILE,
      token:token,
    ).then((value)
    {

      userModel=LoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessProfileState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorProfileState(error));
    }
    );
  }

  //********************************************************************

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }){
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
        url:UPDATE_PROFILE,
        token:token,
        data: {
          'name':name,
          'email':email,
          'phone':phone,

        }
    ).then((value)
      {
      userModel=LoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(ShopSuccessUpdateUserState(userModel));
    }
    );
        // .catchError((error)
    // {
    //   print(error.toString());
    //   emit(ShopErrorProfileState(error));
    // }

  }
}