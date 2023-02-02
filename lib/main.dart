import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_project/components/constance/const.dart';
import 'package:onboarding_project/cubit_shop/shop/cubit_cubit.dart';
import 'package:onboarding_project/layout/HomeScreen.dart';
import 'package:onboarding_project/login/login_Screen.dart';
import 'package:onboarding_project/network/cacheHelper.dart';
import 'package:onboarding_project/network/dio.dart';
import 'package:onboarding_project/on_boarding/onboarding_screen.dart';

int? initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  // SharedPreferences preferences = await SharedPreferences.getInstance();
  // initScreen = preferences.getInt('initScreen');
  // await preferences.setInt('initScreen', 1);

  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  onBoarding == true ? onBoarding : onBoarding = false;

  Widget? widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeScreen();
    } else {
      onBoarding == true ? widget = onBoardingScreen() : widget = LoginScreen();
    }
  }

  runApp(MyApp(
    widget: widget!,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({
    required this.widget,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getUserModel(),
      child: MaterialApp(
        theme: ThemeData(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 20,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
        )),
        debugShowCheckedModeBanner: false,
        // initialRoute: initScreen == 0 || initScreen == null
        //     ? 'onBoardingScreen'
        //     : 'HomeScreen',
        // routes: {
        //   'onBoardingScreen': (context) => onBoardingScreen(),
        //   'LoginScreen': (context) => LoginScreen(),
        //   'HomeScreen': (context) => const HomeScreen(),
        // },
        home: widget,
      ),
    );
  }
}
