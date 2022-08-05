import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/layout/social_app/cubit/cubit.dart';
import 'package:flutter_app/layout/social_app/social_layout.dart';
import 'package:flutter_app/layout/todo_app/ArchivedTasks/ArchivedTasksScreen.dart';
import 'package:flutter_app/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:flutter_app/shared/components/constants.dart';
import 'package:flutter_app/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'modules/bmi_app/bmi_result-screen.dart';
import 'modules/social_app/social_login/social_login_screen.dart';
import 'networks/local/cache_helper.dart';
import 'networks/remote/dio_helper.dart';
import 'obsirver.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper. init();

  bool isDark = CacheHelper.getData(key: 'isDark');

  Widget widget;

  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  //  token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');
  print(token);

  // if(onBoarding != null)
  //   {
  //     if(token != null ) widget = ShopLayout();
  //     else widget = ShopLoginScreen();
  //   }

  if(uId !=null)
  {
    widget = SocialLayout();
  } else{
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}


class MyApp extends StatelessWidget
{
  final bool isDark;
  final Widget startWidget;
  MyApp({
    this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        // BlocProvider(
        // create: (BuildContext context) => AppCubit()
        // ..changeAppMode(
        // fromShared: isDark,
        // ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorits(),
        ),
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        // themeMode: SocialCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        home: BmiResultScreen(),
      ),
    );

  }
}
