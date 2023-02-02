import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_project/components/TestFiled.dart';
import 'package:onboarding_project/components/constance/const.dart';
import 'package:onboarding_project/layout/catergories_Screen.dart';
import 'package:onboarding_project/layout/fav_screen.dart';
import 'package:onboarding_project/layout/product_screen.dart';
import 'package:onboarding_project/layout/settinges_screen.dart';
import 'package:onboarding_project/login/cubit/endPoint.dart';
import 'package:onboarding_project/model_shop_app/Favorites_model.dart';
import 'package:onboarding_project/model_shop_app/categories_model.dart';
import 'package:onboarding_project/model_shop_app/fav_model.dart';
import 'package:onboarding_project/model_shop_app/home_model.dart';
import 'package:onboarding_project/model_shop_app/model_shop.dart';
import 'package:onboarding_project/network/dio.dart';
part 'cubit_state.dart';

class ShopCubit extends Cubit<CubitStates> {
  ShopCubit() : super(CubitInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CattergoriesScreen(),
    const FavoritesScreen(),
    SettingesScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(CubitChangeBottomNavStates());
  }

  HomeModel? homeModel;

  Map<int?, bool?> favorites = {};

  getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      emit(ShopSuccessHomeDataState());

      homeModel = HomeModel.formJson(value.data);
      // print(homeModel!.data!.banners[0].image);
      // print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
      });
      // print(favorites.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      emit(ShopSuccesscategoriesState());
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorcategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      //  print(value.data);
      print(token.toString());
      //  print('token');
      // print(token);

      //print(changeFavoritesModel!.status.toString());
      //  print(changeFavoritesModel!.message.toString());
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavState(model: changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      print(error.toString());
      emit(ShopErrorChangeFavState());
    });
  }

  FavoritesModel? favoritesModel;

  getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      emit(ShopSuccessGetFavState());
      //  print(value.data.toString());
      favoritesModel = FavoritesModel.fromJson(value.data);
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavState());
    });
  }

  LoginModel? userModel;

  getUserModel() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      // print(value.data.toString());
      //
      userModel = LoginModel.fromJson(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataState(loginModel: userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }
}
