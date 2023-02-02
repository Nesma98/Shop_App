// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cubit_cubit.dart';

abstract class CubitStates {}

class CubitInitialStates extends CubitStates {}

class CubitChangeBottomNavStates extends CubitStates {}

class ShopLoadingHomeDataState extends CubitStates {}

class ShopSuccessHomeDataState extends CubitStates {}

class ShopErrorHomeDataState extends CubitStates {}

class ShopErrorcategoriesState extends CubitStates {}

class ShopSuccesscategoriesState extends CubitStates {}

class ShopChangeFavState extends CubitStates {}

class ShopLoadingcategoriesState extends CubitStates {}

class ShopSuccessChangeFavState extends CubitStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavState({required this.model});
}

class ShopErrorChangeFavState extends CubitStates {}

class ShopErrorGetFavState extends CubitStates {}

class ShopSuccessGetFavState extends CubitStates {}

class ShopLoadingGetFavoritesState extends CubitStates {}

class ShopErrorUserDataState extends CubitStates {}

class ShopSuccessUserDataState extends CubitStates {
  final LoginModel loginModel;
  ShopSuccessUserDataState({
    required this.loginModel,
  });
}

class ShopLoadingUserDataState extends CubitStates {}
