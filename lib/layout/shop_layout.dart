import 'package:flutter/material.dart';
import 'package:flutter_app/components/components.dart';
import 'package:flutter_app/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_app/layout/shop_app/cubit/states.dart';
import 'package:flutter_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_app/modules/shop_app/search/search_screen.dart';
import 'package:flutter_app/networks/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop App',
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search
                ),
                onPressed: () {
                navigateTo(context, SearchScreen(),);
              },
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Colors.blue,
                  icon: Icon(
                    Icons.home_filled,
                  ),
                    label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons. apps,
                  ),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons. star_border_outlined,
                  ),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons. settings,
                  ),
                  label: 'Settings',
                ),

              ],
          ),
        );
      },
    );
  }
}
