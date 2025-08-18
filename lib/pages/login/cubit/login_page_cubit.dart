import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:shoppng_app/helper/dio_helper.dart';

import '../../../bottom_nav_bar.dart';
import '../../../helper/hive_helper.dart';
import '../../home/home_page.dart';
import '../login_page.dart';

part 'login_page_state.dart';

class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit() : super(LoginPageInitial());



  void login(String email,String password)async{
    emit(LoginPageLoading());
    final result = await DioHelper.postData("login", body: {"email":email,"password":password});
         if(result.data["status_code"]==200){
           HiveHelper.setToken(result.data["data"]["token"]);
           HiveHelper.setEmail(email);
           Get.off(BottomNavBar());
           emit(LoginPageSuccess());
         } else {
           emit(LoginPageError(message: ' ${result.data["message"]}'));
         }
}

 void logout()async{
    HiveHelper.removeToken();
    Get.offAll(LoginPage());
 }



}
