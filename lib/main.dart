import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shoppng_app/pages/cart/cubit/cart_page_cubit.dart';
import 'package:shoppng_app/pages/home/cubit/home_page_cubit.dart';
import 'package:shoppng_app/pages/home/home_page.dart';

import 'package:shoppng_app/pages/login/cubit/login_page_cubit.dart';
import 'package:shoppng_app/pages/login/login_page.dart';
import 'package:shoppng_app/pages/wishlist/cubit/wishlist_page_cubit.dart';
import 'bottom_nav_bar.dart';
import 'helper/dio_helper.dart';
import 'helper/hive_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.boxTaken);
  await Hive.openBox(HiveHelper.boxEmail);
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
         BlocProvider(create: (context) => LoginPageCubit()),
          BlocProvider(create: (context) => HomePageCubit()..getProduct()..getBanners()),
          BlocProvider(create: (context) => CartPageCubit()..getCart()),
          BlocProvider(create: (context) => WishlistPageCubit()..getWishlist()),

        ],
        child:GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HiveHelper.getToken().isNotEmpty ? BottomNavBar() : LoginPage(),
    )
    );
  }
}

