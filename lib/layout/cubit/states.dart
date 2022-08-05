import 'package:flutter_app/models/shop_app/change_favorites_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';
import 'package:flutter_app/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates
{
  final String error;

  ShopErrorGetFavoritesState(this.error);
}


// Profile States
class ShopSuccessProfileState extends ShopStates {}

class ShopLoadingGetProfileState extends ShopStates {}

class ShopErrorProfileState extends ShopStates
{
  final String error;

  ShopErrorProfileState(this.error);
}

class ShopSuccessUpdateUserState extends ShopStates
{
  final LoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopErrorUpdateUserState extends ShopStates
{
  final String error;

  ShopErrorUpdateUserState(this.error);
}


