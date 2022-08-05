
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_app/networks/local/cache_helper.dart';

void signOut(context)
{
  CacheHelper.removeData(Key: 'token',).then((value) {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');  // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)) );
}


String token = '';
String uId = 'T8sBlIRbE4QuxVTZSGSjBFhiKRb2';
User user;